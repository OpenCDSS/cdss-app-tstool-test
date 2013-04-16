c This version has been updated by Steve Malers to print more output for troubleshooting
c Specific changes:
c
c * Allow filenames to be up to 128 characters (was 16)
c
c        data fillin for large matrix of flow data
c             dimensioned for "maxts" stations and "maxn" time periods (200 years of monthly data)
c        does not fill zero values or use them in the regression.
c        assumes flows are read in by water year.
c	 confidence interval is 95%
c
      program fillin
      parameter(maxts=300,maxn=2400)
c     implicit none
      character*8 jsta(maxts)
      character*128 FILENAME
      common /c1/
     +    nsta,		! number of stations
     +    n,		! number of data points (nyears*ncycle)
     +    ncycle,	! number of equations (1 or 12)
     +    nyears,	! number of years of data
     +    icd,		! card number when reading data - why common?
     +    ibeg,		! first time series number (1)
     +    iend,		! last time series number (count)
     +    imode,	! method 1=monthly, 2=1 equation, 3=try each?
     +    sig		! level of significance ((1 - conf level %/100))/2
      common /c2/
     +    x(maxts,maxn),
     +    istrt
      common /c3/
     +    temp(maxn),
     +    method,
     +    numb
c
      write(*,'(a)') ' Enter the file name for the input data     : '
      read (*,*) FILENAME
      write(*,*) 'Opening input file: ', FILENAME
      open(10,file=FILENAME)
      write(*,'(a)') ' Enter the file name for the data output    : '
      read (*,*) FILENAME
      write(*,*) 'Opening output time series file: ', FILENAME
      open(11,file=FILENAME)
      write(*,'(a)') ' Enter the file name for the summary output : '
      read (*,*) FILENAME
      write(*,*) 'Opening summary output file: ', FILENAME
      open(20,file=FILENAME)
c	Read the header information
      read(10,1000) imode,method,numb,ibeg,iend,iout,istrt,anogo,sig
 1000 format(6i3,i5,f5.0,f5.3)
      write(20,1010) imode,method,numb,maxts,ibeg,iend,iout,istrt,
     +    anogo,sig
 1010 format (8himode  =,i5,47h  [1=linear regression,2=MOVE.1,3=MOVE.2,
     14=RPN]  ,/,
     2 8hmethod =,i5,37h  [1=cyclic,2=noncyclic,3=variable]  ,/,
     3 8hnumb   =,i5,65h  [0=use all sites as independent variables,1-',i4,
     4=indicated site]  ,/,
     5 8hibeg   =,i5 ,/,
     6 8hiend   =,i5,47h  [index of first and last dependent variable]
     7 ,/,8hiout   =,i5,53h  [1=show table of independent variables,0=no
     8 table]  ,/,
     9 8histrt  =,i5,35h  [first year of extended record] ,/,
     1 8hanogo  =,f6.0,' [minimum number of concurrent values needed]',/,
     2 8hsig    =,f6.3,' [level of significance for regression slope]')
      call fillx1 (jsta)
      call fillx2 (iout,anogo,jsta)
      CLOSE(10)
      CLOSE(11)
      CLOSE(20)
      stop
      end
c **********************************************************************
      subroutine fillx1(jsta)
c        fills in x-array with logs of measured values
C	reads the data records from the file and converts to log
      parameter(maxts=300,maxn=2400)
      dimension flow(6)
      character*8 jsta(maxts)
      common /c1/ nsta,n,ncycle,nyears,icd,ibeg,iend,imode,sig
      common /c2/
     *    x(maxts,maxn),	! time series by number of months
     *    istrt		! first year in analysis
      character*8 ista,istb
c
      ncycle=12
      icd=1
c     initialize all data values to missing (-999)
      do 10 i=1,maxts
          do 10 j=1,maxn
   10 x(i,j)=-999.
      nsta=0	! number of stations read
      istb=' '	! station name being read
      ilast=istrt
c	Read time series.  Full period is read for a station before
c	going to the next station.  6 values per line, so 2 lines for 12 values.
   20 read(10,1000,end=60) itype,ista,iyear,icard,(flow(k),k=1,6)
 1000 format(I8,A8,I4,I4,6F9.0)
      if(iyear.lt.istrt) go to 20	! skip data not in the analysis period
      if(iyear.gt.ilast) ilast=iyear
      if(ncycle.lt.12.and.icd.ne.icard) go to 20
      if(ncycle.lt.12.and.icd.eq.2) icard=icard-1
      if(nsta.eq.0) go to 30
      if(ista.eq.istb) go to 40
   30 nsta=nsta+1
      jsta(nsta)=ista
      istb=ista
   40 iadd=(iyear-istrt)*ncycle + (icard-1)*6
      do 50 i=1,6
          if(flow(i).lt. -.01) flow(i)=-999.
          if((flow(i).lt. .01).and. (flow(i) .gt. -.01)) flow(i)=-2.
          if(flow(i).gt.0.) flow(i)=xlog10(flow(i))
   50 x(nsta,iadd+i)=flow(i)
      go to 20
c
   60 continue
      nyears=ilast-istrt+1
      n=ncycle*nyears
      if (iend .gt. nsta) iend=nsta
      return
      end
c **********************************************************************
      function xlog10(x)
      y=-2
      if(x) 20,20,10
   10 y=alog10(x)
   20 xlog10=y
      return
      end
c **********************************************************************
      subroutine fillx2 (iout,anogo,jsta)
c        subroutine to fill in missing data
      parameter(maxts=300,maxn=2400)
      CHARACTER*1 EST(maxn)
      character*8 jsta(maxts)
      dimension x2(maxn),x1x2(maxn)
      common /c1/ nvar,n,ncy,nyears,icd,ibeg,iend,imode,sig
      common /c2/ x(maxts,maxn),istrt
      common /c3/ temp(maxn),method,numb
      common /c6/ se(maxn),EST
      common /c9/ ipred(maxn),ipot(600),concur(600),corcf(600,12)
      real mx,mx1,mx2,my,my1,my2
      integer concur
c
c        initialize based on value of method
c
      kkbeg=1
      kkend=2
      jvar1=1
      jvar2=2*nvar
      go to (10,20,30),method
   10 kkend=1
      jvar2=nvar
      go to 30
   20 kkbeg=2
      jvar1=nvar+1
   30 continue
      tt1=0.
      ttse=0.
      ncyp=ncy+1
c
      do 300 ivar=ibeg,iend
      write (6,1000) ivar, jsta(ivar)
 1000 format ('Working on dependent variable ',i3,' ',A8)
      do 35 i = 1,600
   35 ipot(i) = 0
      do 40 i=1,n
      se(i)=1.0e10
      EST(i)=' '
      ipred(i)=0
      temp(i)=x(ivar,i)
      if(temp(i).gt.-90.) se(i)=0.
      IF (temp(i) .LT. -90.0) EST(i)= 'e'
   40 continue
c
c        compute statistics of observed values of dependent variable
c
      call msd2(temp,maxn,n,-90.,my1,sdy1,t)
      write(20,1010) jsta(ivar),ivar,t,my1,sdy1
 1010 FORMAT(
     1//,' Analysis for:   Station number ',a8,
     2'    Variable  ',i4,
     3//,t20,'Population Size       = ',f9.0,
     4/,t20,'Population Mean       = ',f9.2,
     5/,t20,'Population Std. Dev.  = ',f9.3)
      ps=t
c
c        compute cross correlations and fill data with the smallest
c             standard error of prediction
c
      do 170 jvar=1,nvar  ! Loop through the number of time series
          if(numb.gt.0 .and. jvar.ne.numb) go to 170  ! requested a specific independent but not matched
          if(jvar.eq.ivar) go to 170  ! don't test against itself
          write (6,1020) jvar,jsta(jvar)
 1020     format ('      computations using independent variable ',i3,
     *        ' ',A8)
c
          do 160 kk=kkbeg,kkend
              iplus=kk-1
              ncycle=ncy-(ncy-1)*iplus
              ident=jvar + nvar*iplus
              icount=0
              ss=0.
c
              do 150 icycle=1,ncycle   ! loop through the number of equations
c
c                preliminary check for useful predictor values
c
                  do 50 i=icycle,n,ncycle
                      if(x(ivar,i).lt.-90..and.x(jvar,i).gt.-1.) goto 60
   50             continue
                  go to 150  ! go to next equation in loop
c
   60         s=0.
              slope=0.
              cept=0.
              corcof=0.
              corcf(ident,icycle) = 1.0e10
              see=1.0e10
              sx=0.
              sy=0.
              sx1=0.
              sy1=0.
              sxy=0.
              xmin=1.0e10
              xmax=-1.0e10
              ymin=1.0e10
              ymax=-1.0e10
              n1n2=0
              n2=0
c
c        compute statistics for concurrent data
c
              do 80 i=icycle,n,ncycle
                  if(x(jvar,i).lt.-1.) go to 80
                  n1n2=n1n2+1
                  x1x2(n1n2)=x(jvar,i)
                  if(x(ivar,i).lt.-1.) go to 70
                  s=s+1.
                  xi=x(ivar,i)
                  xj=x(jvar,i)
                  sx=sx+xj
                  sy=sy+xi
                  sx1=sx1+xj*xj
                  sy1=sy1+xi*xi
                  sxy=sxy+xi*xj
                  xmin=amin1(xmin,xj)
                  xmax=amax1(xmax,xj)
                  ymin=amin1(ymin,xi)
                  ymax=amax1(ymax,xi)
                  go to 80
c
c        fill array x2 for move.2 statistics
c
   70             n2=n2+1
                  if(imode.eq.3) x2(n2)=x(jvar,i)
   80          continue
               ss = ss + s
c
c        compute parameters for extension equation
c
               if(s.lt.anogo) go to 150
               if(xmin .ge. xmax) go to 150
               if(ymin .ge. ymax) go to 150
               n1=s
               my1=sy/s
               mx1=sx/s
               ssxy=sxy-sx*my1
               ssx=sx1-sx*mx1
               ssy=sy1-sy*my1
               if ( (ssx*ssy) .le. 0. ) goto 150
               if ( (ssy/(s-1.)) .le. 0. ) goto 150
               if ( (ssx/(s-1.)) .le. 0. ) goto 150
               sy1=sqrt(ssy/(s-1.))
               sx1=sqrt(ssx/(s-1.))
               corcof=ssxy/(sqrt(ssx*ssy))
               ssr=ssxy*ssxy/ssx
               ssd=ssy-ssr
               if ((ssd/(s-2.)) .le. 0.) goto 150
               see=sqrt(ssd/(s-2.))
c
c        test for significance of regression slope
c
               if ( ssx .le. 0. ) goto 150
               tstat=ssxy/see/sqrt(ssx)
               tstat1=abs(tstat)
               df=s-2.
               tstat2 = STUTX(sig,df)
               write(*,*) 'tstat from data=',tstat1,' tstat required=',
     +             tstat2
               if(tstat1.lt.tstat2) go to 150
               corcf(ident,icycle)=corcof
               if(imode.eq.2) corcof=1.0
c
c        choose and store predicted values
c
               do 130 i=icycle,n,ncycle
                   if(x(jvar,i).lt.-1.) go to 130
                   if(se(i) .le. 0.) go to 130
                   icount=icount+1
                   dev=x(jvar,i)-mx1
                   if(dev) 90,90,100
   90                  range=mx1-xmin
                       go to 110
  100                  range=xmax-mx1
  110                  if( (1.+1./s+(dev*dev/ssx)) .le. 0.) goto 130
                   sep=see*sqrt(1. + 1./s +(dev*dev/ssx))
                   sep=sep*2.3026
                   sep2=sep*sep
                   if( (sep2-1.) .gt. 10.) goto 130
                   if ( (exp(sep2)-1.) .le. 0.) goto 130
                   sep=100.*sqrt(exp(sep2)-1.)
                   if(se(i).lt.sep) go to 130
                   se(i)=sep
                   ipred(i)=ident
                   temp(i)=my1 + corcof*(sy1/sx1)*(x(jvar,i)-mx1)
CCCCC if(imode.eq.4) call noise(temp(i),n1,n2,sy1,corcof,irand)
                   if(imode.ne.3) go to 130
c
c          compute move.2 statistics
c
                   if(n2.lt.2) go to 130
                   call msd2(x2,maxn,n2,-90.,mx2,sx2,t)
                   call msd2(x1x2,maxn,n1n2,-90.,mx,sx,t2)
                   vy1=sy1*sy1
                   vx2=sx2*sx2
                   call move2(x(jvar,i),tmp,n1n2,n2,mx2,mx1,my1,slope,
     *                 vy1,vx2,corcof,sx,mx)
                      temp(i)=tmp
  130             continue
  150         continue
              ipot(ident)=icount
              concur(ident)=ss
  160     continue
  170 continue
c
      iyear=istrt-1
      if(iout.eq.0) go to 200
      write(20,1030)
 1030 format(//,
     1 6x,'Number of the independent station used to predict the depende
     2nt station ' ,/,
     3 '  year   Oct   Nov   Dec   Jan   Feb   Mar   Apr   May   Jun   J
     4ul   Aug   Sep')
      do 190 i=1,n,ncy
          m=i+(ncy-1)
          iyear=iyear+1
          if(ncy.lt.12.and.icd.eq.2) go to 180
          write(20,1040)iyear,(ipred(j),j=i,m)
 1040     format(13i6)
          go to 190
  180     write(20,1050) iyear,(ipred(j),j=i,m)
 1050     format(i6,36x,6i6)
  190 continue
  200 continue
c
c        write number of predictors and correlation coefficients.
c
      write(20,1060)
 1060  format(//,
     1 21h           Po          ,/,
     2 21h      Con  ten  Act    ,/,
     3 21h      cur  tial ual    ,/,
     4 21h      rent Pre  Pre    ,/,
     5 21h Vari Sam  dict dict   ,/,
     6 47h able ples ors  ors   Correlation Coefficients   ,/)
      do 220 jvar=jvar1,jvar2
          ncycle=ncy
          if(jvar.gt.nvar) ncycle=1
          kount=0
          do 210 i=1,n
              if(ipred(i).ne.jvar) go to 210
              kount=kount+1
  210     continue
          if(ipot(jvar).eq.0) go to 220
          write(20,1070) jvar,concur(jvar),ipot(jvar),kount,
     *        (corcf(jvar,icycle),icycle=1,ncycle)
 1070     FORMAT(4I5,12(1X,F4.2))
  220 continue
c
c        compute errors in the estimated values
c
  230 tmiss=0.
      t1=0.
      tse=0.
      do 250 i=1,n
c         SAM add this line
          write(*,*) 'i=',i,' se(i)=',se(i)
          if(temp(i).lt.-90.) go to 240
          tse=tse+se(i)
          if(se(i) .le. 0.) t1=t1+1.
          go to 250
  240     tmiss=tmiss+1
  250 continue
      tt1=tt1+t1
      ttse=ttse+tse
      if(t1 .le. 0.) tse=tse/t1
      call msd2(temp,maxn,n,-90.,tmean,tsd,t)
      if((t-ps) .gt. 0.0) tse=(tse/(t-ps))
      write(20,1080) t,tmean,tsd,tse,tmiss
 1080 format (//,10x,24hResultant sample size = ,
     1 f6.0,/,10x,17hPredicted mean = ,
     2 f9.2,/,10x,21hPredicted std dev. =  ,f9.3,/,10x,
     3 39hAverage standard error of prediction =  ,f9.1,/,10x,
     4 42hNumber of variables with no predictors =  ,f6.0)
c
c        convert from log-space
c
  260 do 270 i=1,n
          if(temp(i).lt.-90.) go to 270
          temp(i)=10**temp(i)
  270 continue
c
c        save extended record
c
      iyr=istrt-1
      j1=1
      j2=6
      do 290 i=1,nyears
          iyr=iyr+1
          do 290 ii=1,2
              DO 280 j=j1,j2
                  if (temp(j) .lt. -10.) goto 280
                  if((temp(j) .le. .01) .and. (temp(j) .gt. -1.))
     *                temp(j)=0.0
  280         continue
              write(11,1090) jsta(ivar),iyr,ii,(temp(j),est(j),j=j1,j2)
 1090         format(7X,1H1,A8,I4,I4,6(F9.1,A1))
              j1=j1+6
              j2=j2+6
  290     continue
  300 continue
c
      write(20,1100) ttse,tt1
 1100 format (//,31h The total predicted error was ,f13.2,5h for ,
     1 f6.0,12h predictions  )
      return
      end
c **********************************************************************
      subroutine msd2(y,num,n,bmin,ymean,ysd,t)
      real y(num)
      sy=0.
      sy2=0.
      t=0.
c **** setting mean and std.to zero
	ymean=0.
	ysd=0.
	  
      do 10 i=1,n
      if(y(i).lt.bmin) go to 10
      t=t+1.
      sy=sy+y(i)
      sy2=sy2+y(i)*y(i)
   10 continue
C  **** Check for no data, if none return
      if(t.le.0.) go to 20
      ymean=sy/t
	if(t.le.1.) go to 20
      ysd=sqrt((sy2-sy*sy/t)/(t-1.))
   20 return
      end
c **********************************************************************
      subroutine move2(x,y,n,n2,mx2,mx1,my1,b,vy1,vx2,r,sx,mx)
c        record reconstruction by method MOVE.2
c             (maintainence of varience extension . 2)
      real mx1,mx2,my1,my2,my,mx,mdif
      n1 = n -n2
      rn = n
      rn1 = n1
      rn2 = n2
      alpha2 = rn2*(rn1-4.0)*(rn1-1.0)/((rn2-1.0)*(rn1-3.0)*
     1(rn1-2.0))
      mdif = mx2-mx1
      my=my1+(rn2/rn)*b*mdif
      a1=(rn1-1.0)*vy1
      a2=(rn2-1.0)*b*b*vx2
      a3=(rn2-1.0)*alpha2*(1.0-r**2)*vy1
      a4=(rn1*rn2/rn)*b*b*mdif*mdif
      vy=(1.0/(rn-1.0))*(a1+a2+a3+a4)
      sy=sqrt(vy)
      sratio=sy/sx
      y=my+sratio*(x-mx)
      return
      end
c **********************************************************************
      FUNCTION STUTX(P,dgfr)
C        STUDENT T QUANTILES --
C        STUTX(P,N) = X SUCH THAT PROB(STUDENT T WITH N D.F. .LE. X) = P
C             NOTE - ABS(T) HAS PROB Q OF EXCEEDING STUTX( 1.-Q/2., N ).
C             NOTE - IER - ERROR FLAG --  1 = F.LT.1.,
C                                         2 = P NOT  IN (0,1),
C                                         3 = 1+2
C        SUBPGMS USED -- GAUSAB     (GAUSSIAN ABSCISSA)
C
C        REF - G. W. HILL (1970) ACM ALGO 396.  COMM ACM 13(10)619-20.
C             REV BY WKIRBY 10/76. 2/79.  10/79.
C
      DATA HPI / 1.5707963268/
C
      n = dgfr
      SIGN=1.
C     IF(P.LT.0.5)SIGN=-1.
      Q=2.*P
      IF(Q.GT.1.)Q=2.*(1.-P)
      IF(Q.LT.1.)GO TO 10
      STUTX = 0.
      RETURN
C
   10 CONTINUE
      FN = N
      IF(N.GE.1 .AND. Q.GT.0. .AND. Q.LT.1.) GO TO 20
      IER = 3
      IF(N.GE.1) IER = 2
      STUTX = SIGN*1E38
      RETURN
C
   20 IF(N.NE.1) GO TO 30
C  -- 1 DEG FR - EXACT
      STUTX=SIGN/TAN(HPI*Q)
      RETURN
C
   30 IF(N.NE.2) GO TO 40
C  -- 2 DEG FR - EXACT
      STUTX = SQRT(2.0/(Q*(2.0-Q))-2.0) * SIGN
      RETURN
C
C  -- EXPANSION FOR N .GT. 2
   40 A = 1.0/(FN-0.5)
      B= 48.0/(A*A)
      C=((20700.*A/B-98.)*A-16.)*A+96.36
      D =  ((94.5/(B+C)-3.)/B+1.)*SQRT(A*HPI)*FN
      X = D*Q
      Y = X**(2.0/FN)
      IF (Y .GT. A+.05) GO TO 50
      Y = ((1.0/(((FN+6.)/(FN*Y)-0.089*D-0.822)*(FN+2.)*3.)+
     1   0.5/(FN+4.))*Y-1.)*(FN+1.)/(FN+2.)+1.0/Y
      STUTX = SQRT(FN*Y) * SIGN
      RETURN
C
C   -- ASYMPTOTIC INVERSE EXPANSION ABOUT NORMAL
   50 X = GAUSAB(0.5*Q)
      Y =  X*X
      IF (FN .LT. 5.) C = C+0.3*(FN-4.5)*(X+0.6)
      C = (((.05*D*X-5.)*X-7.)*X-2.)*X+B+C
      Y = (((((0.4*Y+6.3)* Y+36.)*Y+94.5)/C-Y-3.)/B+1.)*X
      X = A*Y**2
      Y = X + 0.5*X**2
      IF (X .GT. .002) Y = EXP(X) - 1.0
      STUTX = SQRT(FN*Y) * SIGN
      RETURN
      END
c **********************************************************************
      FUNCTION GAUSEX(EXPROB)
C
C        GAUSSIAN PROBABILITY FUNCTIONS   W.KIRBY  JUNE 71
C        GAUSEX=VALUE EXCEEDED WITH PROB EXPROB
C        GAUSAB=VALUE (NOT EXCEEDED) WITH PROBCUMPROB
C        GAUSCF=CUMULATIVE PROBABILITY FUNCTION
C        GAUSDY=DENSITY FUNCTION
C
C        SUBPGMS USED -- NONE
C
C        GAUSCF MODIFIED 740906 WK -- REPLACED ERF FCN REF BY RATIONAL
C             APPRX N
C        ALSO REMOVED DOUBLE PRECISION FROM GAUSEX AND GAUSAB.
C        76-05-04 WK -- TRAP UNDERFLOWS IN EXP IN GUASCF AND DY.
C
       DATA  XLIM  /  18.3 /
          DATAC0,C1,C2/2.51551700, .8028530000, .0103280000/
          DATAD1,D2,D3/1.432788000, .1892690000, .0013080000/
C
          P=EXPROB
   10 IF(P.LT.1.0)GOTO20
      GAUSEX=-10.
      RETURN
C
   20 IF(P.GT.0.)GOTO30
       GAUSEX=+10.
       RETURN
   30  PR=P
      IF(P.GT..5)PR=1.00-PR
       T= SQRT(-2.00*ALOG(PR))
       GAUSEX=T-(C0+T*(C1+T*C2))/(1.D0+T*(D1+T*(D2+T*D3)))
      IF(P.GT..5)GAUSEX=-GAUSEX
      RETURN
C
      ENTRY GAUSAB(CUMPRB)
      GAUSAB = 0.
      P=1.-CUMPRB
      GOTO10
C
      ENTRY GAUSCF(XX)
      AX=ABS(XX)
      GAUSCF=1.
      IF(AX.GT.XLIM)GOTO40
      T=1.0/(1.0+.2316419*AX)
      D=0.3989423*EXP(-XX*XX*.5)
      GAUSCF=1.-D*T*((((1.330274*T - 1.821256)*T + 1.781478)*T -
     1 0.3565638)*T + 0.3193815)
   40 IF(XX.LT.0)GAUSCF=1.-GAUSCF
      RETURN
C
      ENTRY GAUSDY (XX)
      GAUSDY=0.
      IF(ABS(XX).GT.XLIM)  RETURN
      GAUSDY=.3989423*EXP(-.500*XX*XX)
      RETURN
      END
c **********************************************************************
c     subroutine noise(y,n1,n2,sy1,r,irand)
c          adds noise term to simple linear regression
c     S=1.
c     AM=0.0
c     A =0.0
c     kvalue = 2.0
c     DO 50 I=1,50
c50   A = A+RAND$A(IRAND)
c     R6 = ((A-10.)/1.29099448)*S+AM
c     R6 = ((A-25.)/1.991)*S+AM
c     rn1=n1
c     rn2=n2
c     if(n1.le.4.or.n2.le.1) print *, 'Error in noise'
c     bot=(rn2-1.)*(rn1-3.)*(rn1-2.)
c     top=rn2*(rn1-4.)*(rn1-1.)*(1.0-r*r)
c     alpha=sqrt(top/bot)
c     y=y+alpha*sy1*R6
c     return
c     end
