############################################################
#
# FillRegression
#
# Main test script for reproducing TSTool FillRegression
# statistics calculations.
#
############################################################

# import build-in modules
import logging
import sys
import string
import traceback

# import user-defined modules
import Statistics
import StudentTQuantiles
import Read_TS
import Write_Stats

def main ( independentBaseName, dependentBaseName, independentTSID, dependentTSID, statisticsFile, nEquations ):
    """
    Function that does all of the calculation work
    independentBaseName - path to the base filename of independent time series (no .csv or _01.csv at end)
    dependentBaseName - path to the base filename of dependent time series (no .csv or _01.csv at end)
    indepedentTSID - the independent TSID to use in the IndependentTSID column of the statistics table
    depedentTSID - the dependent TSID to use in the DependentTSID column of the statistics table
    statisticsFile - path to the output statistics file
    nEquations - number of equations (1 or 12)
    """
    # Get the logger for diagnostics and print out command line parameters (use str() in case None)
    logger = logging.getLogger()
    logger.info ( "independentBaseName='" + str(independentBaseName) + "'" )
    logger.info ( "dependentBaseName='" + str(dependentBaseName) + "'" )
    logger.info ( "independentTSID='" + str(independentTSID) + "'" )
    logger.info ( "dependentTSID='" + str(dependentTSID) + "'" )
    logger.info ( "statisticsFile='" + str(statisticsFile) + "'" )
    logger.info ( "nEquations=" + str(nEquations) )
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
    _SkewY=[]
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

        # Override the TSID with that from the command line
        #if ( dependentTSID != None ):
        #     TSID = dependentTSID
        #if ( independentTSID != None ):
        #     TSID_Indep = independentTSID

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
        SkewY = Statistics.Skew(Y)

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
        _SkewY.append(SkewY)
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
                        _SkewY,
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
    logger.info ('Statistics file written')
    print ('Statistics file written')

def initLogging ( logFile ):
    """
    Set up basic logging using the logfile that is specified on the command line
    """
    logging.basicConfig(
        filename=logFile,
        level=logging.INFO,
        format='%(asctime)s %(levelname)-8s %(message)s',
        filemode='w'
    )

def parseArgs ():
    """
    Parse the command line arguments to determine the input needed for the script
    Return as a tuple of:
    independentBaseName - path to the base filename of independent time series (no .csv or _01.csv at end)
    dependentBaseName - path to the base filename of dependent time series (no .csv or _01.csv at end)
    indepedentTSID - the independent TSID to use in the IndependentTSID column of the statistics table
    depedentTSID - the dependent TSID to use in the DependentTSID column of the statistics table
    statisticsFile - path to the output statistics file
    nEquations - number of equations (1 or 12)
    logFile - path to the logfile
    """
    independentBaseName = None
    dependentBaseName = None
    independentTSID = None
    dependentTSID = None
    statisticsFile = None
    nEquations = None
    logFile = None
    #
    # Loop through command line arguments
    for arg in sys.argv:
        parts = arg.split('=')
        if ( (parts == None) or (len(parts) != 2) ):
            # Not an arg=value command line argument
            continue
        argName = parts[0].upper()
        argValue = parts[1]
        if ( argName == 'DEPENDENTBASENAME' ):
            dependentBaseName = argValue
        elif ( argName == 'DEPENDENTTSID' ):
            dependentTSID = argValue
        elif ( argName == 'INDEPENDENTBASENAME' ):
            independentBaseName = argValue
        elif ( argName == 'INDEPENDENTTSID' ):
            independentTSID = argValue
        elif ( argName == 'LOGFILE' ):
            logFile = argValue
        elif ( argName == 'NUMBEROFEQUATIONS' ):
            nEquations = int(argValue)
        elif ( argName == 'STATISTICSFILE' ):
            statisticsFile = argValue
    return ( independentBaseName, dependentBaseName, independentTSID, dependentTSID,
        statisticsFile, nEquations, logFile )

def printUsage():
    """
    Print the script usage to standard out.
    """
    print
    print "Usage:  python FillRegression.py args"
    print
    print "where args are property pairs as follows...."
    print "IndependentBaseName=XXXX - path to the base filename of independent time series (no .csv or _01.csv at end)"
    print "DependentBaseName=XXXX - path to the base filename of dependent time series (no .csv or _01.csv at end)"
    print "IndepedentTSID=XXXX - the independent TSID to use in the IndependentTSID column of the statistics table"
    print "DepedentTSID=XXXX - the dependent TSID to use in the DependentTSID column of the statistics table"
    print "StatisticsFile=XXXX - path to the output statistics file"
    print "NumberOfEquations=XXXX - number of equations (1 or 12)"
    return

#===============================================================================
# Entry point into the script, which calls the main function.
# Put at the end because functions need to be defined before they can be called
#===============================================================================
if ( __name__ == "__main__" ):
    try:
        logFile = None
        ( independentBaseName, dependentBaseName, independentTSID, dependentTSID,
            statisticsFile, nEquations, logFile ) = parseArgs ()
        if ( logFile == None ):
            # Logfile is required because we want it to end up in the "Resuls" folder that is not
            # under revision control
            print "LogFile command line parameter must be specified"
            printUsage()
            exit(1)
        #
        # Set up logging
        initLogging ( logFile )
        #
        # Run the main function, which does all the work
        main ( independentBaseName, dependentBaseName, independentTSID, dependentTSID, statisticsFile, nEquations )
        # TODO - this is a way to deep checks for errors but don't implement here yet
        #if ( loggingutil.warningCount > 0 ):
        #    print ("There were " + str(loggingutil.warningCount) +
        #        " warnings processing data.  See the log file \"" + LOGFILE + "\".")
    except SystemExit, error:
        # This exception is raised when system.exit() is called.
        # Just let normal exit happen to shut down this script.
        print 'Exiting (' + str(error) + ')'
        # Call the internal function to close out gracefully
        exit(int(str(error)))
    except:
        # Using the logger here assumes that basic logging setup was successful
        # in the main function.
        logger = logging.getLogger()
        if ( (logger == None) or (logFile == None) ):
            print 'Unexpected error'
            traceback.print_exc()
        else:
            logger.exception ( "Unexpected exception" )
            print 'Unexpected error.  See the detail in \"' + str(logFile) + '"'
            traceback.print_exc()
        printUsage()
        exit(1)

    # Done - exit with success status (no exception handled because script is done)
    # Probably won't get here because system.exit() gets called once and is
    # therefore handled in the above SystemExect except.
    exit(0)
