############################################################
#
# FillRegression
#
############################################################

# import build-in modules
import sys
import string

# import user-defined modules
import Statistics
import StudentTQuantiles
import Read_TS
import Write_Stats

# Define lists
_TSID=[]
_TSID_Indep=[]
_n1=[]
_MeanX1=[]
_SX1=[]
_n2=[]
_MeanX2=[]
_SX2=[]
_MeanY1=[]
_SY1=[]
_NY=[]
_MeanY=[]
_SY=[]
_a=[]
_b=[]
_R=[]
_R2=[]
_meanY1Est=[]
_SY1Est=[]
_RMSE=[]
_SEE=[]
_SEP=[]
_SESlope=[]
_TestScore=[]
_TestQuantile=[]
_TestRelated=[]
_Y2=[]
_MeanY2=[]
_SY2=[]
_Skew=[]

# Set values
missingValue = -999
p = 0.95                        # p = one sided exceedence probability

# Read command line arguments
independentBaseName = sys.argv[1]
dependentBaseName = sys.argv[2]
statisticsFile = sys.argv[3]    # Output file
nEquations = int(sys.argv[4])   # Number of equations

# Read data and determine statistics
for i in range (0,nEquations):
    # Construct name based on number of equations
    if nEquations == 1:
        independentName = independentBaseName + '.csv'
        dependentName = dependentBaseName + '.csv'
    else:
        monthsString = string.rjust(str(i+1),2)
        monthsString = string.replace(monthsString,' ', '0')
        monthsString = '_' + monthsString
        independentName = independentBaseName + monthsString + '.csv'
        dependentName = dependentBaseName + monthsString + '.csv'

    # Read the data from the CSV files
    [TSID_Indep, X] = Read_TS.Read_CSV(independentName)
    [TSID, Y] = Read_TS.Read_CSV(dependentName)

    # remove missing values
    [independent, x_n2, dependent, n1, n2] = Statistics.overlapping(X, Y, missingValue)

    # calculate basic statistics
    [MeanX1, SX1]=Statistics.statistics(independent)
    [MeanY1, SY1]=Statistics.statistics(dependent)
    if x_n2 != []:
        [MeanX2, SX2]=Statistics.statistics(x_n2)
    else:     # No data that can be filled
        [MeanX2, SX2]=[missingValue, missingValue]

    # calculate additional statistics for dependent variable
    [MeanY, NY, SY]=Statistics.dependent_statistics(Y, missingValue)

    # calculate regression coefficients
    [a,b,R,R2]=Statistics.regression_coef(independent, dependent)

    # Estimate the values for the dependent variable
    [Yest, meanY1Est, SY1Est]=Statistics.calculate_Yest(independent, a, b)

    # Calculated the estimates for the dependent variable
    if x_n2 != []:
        Y2 = Statistics.LinearRegression(a,b,x_n2)
        [MeanY2, SY2]=Statistics.statistics(Y2)
    else:      # No data that can be filled
        Y2 = []
        [MeanY2, SY2]=[missingValue, missingValue]

    # Calculate additional statistics
    if x_n2 != []:
        Skew = Statistics.Skew(Y2)
        RMSE = Statistics.RMSE(dependent, Yest, n1)
        SEE = Statistics.SEE(dependent, Yest, n1)
        SEP = Statistics.SEP(independent, SEE, n1)
        SESlope = Statistics.SESlope(independent, dependent, Yest, n1)
        TestScore = Statistics.TestScore(b, SESlope)
        TestQuantile = StudentTQuantiles.Student_T_quantile (p,n1-2)
        if TestScore >= TestQuantile:
            TestRelated = 'Yes'
        else:
            TestRelated = 'No'
    else:       # No data that can be filled
        Skew = missingValue
        RMSE = missingValue
        SEE = missingValue
        SEP = [missingValue]
        SESlope = missingValue
        TestScore = missingValue
        TestQuantile = missingValue
        TestRelated = 'No'

    # Append all the monthly data to an array containing the data for all months
    # This will create a list with a single entry for a run with one equation
    _TSID.append(TSID)
    _TSID_Indep.append(TSID_Indep)
    _n1.append(n1)
    _MeanX1.append(MeanX1)
    _SX1.append(SX1)
    _n2.append(n2)
    _MeanX2.append(MeanX2)
    _SX2.append(SX2)
    _MeanY1.append(MeanY1)
    _SY1.append(SY1)
    _NY.append(NY)
    _MeanY.append(MeanY)
    _SY.append(SY)
    _a.append(a)
    _b.append(b)
    _R.append(R)
    _R2.append(R2)
    _meanY1Est.append(meanY1Est)
    _SY1Est.append(SY1Est)
    _RMSE.append(RMSE)
    _SEE.append(SEE)
    _SEP.append(SEP)
    _SESlope.append(SESlope)
    _TestScore.append(TestScore)
    _TestQuantile.append(TestQuantile)
    _TestRelated.append(TestRelated)
    _Y2.append(Y2)
    _MeanY2.append(MeanY2)
    _SY2.append(SY2)
    _Skew.append(Skew)

# Pass the lists with all information to be written to a CSV file
Write_Stats.Write_CSV(statisticsFile,
                        _TSID,
                        _TSID_Indep,
                        _n1,
                        _MeanX1,
                        _SX1,
                        _n2,
                        _MeanX2,
                        _SX2,
                        _MeanY1,
                        _SY1,
                        _NY,
                        _MeanY,
                        _SY,
                        _a,
                        _b,
                        _R,
                        _R2,
                        _meanY1Est,
                        _SY1Est,
                        _RMSE,
                        _SEE,
                        _SEP,
                        _SESlope,
                        _TestScore,
                        _TestQuantile,
                        _TestRelated,
                        _Y2,
                        _MeanY2,
                        _SY2,
                        _Skew)

print ('Statistics file written')
