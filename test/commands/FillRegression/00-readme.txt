This file explains how the FillRegression() command is tested.


INTRODUCTION


Many TSTool commands have logic that is simple enough to visually inspect 
results to confirm functionality.  This allows for straightforward creation of
the "ExpectedResults" files, which can then be compared with the "Results" in
 subsequent development and testing.  However, FillRegression() is more complex
 because mathematical formulas are used to compute statistics, and multiple 
analysis steps are used to compute all the statistics.  Additionally, the
FillRegression() command has other features that complicate testing, including
 allowing data to be transformed to log values prior to analysis, and allowing 
monthly relationships to be used.  In order to provide flexibility and prevent 
the user from inappropriately filling data, optional command parameters also 
are available to ensure that minimum sample size and R^2 and also that the data 
pass the T-test.  The internal calculations are performed on arrays of numbers; 
however, data management transferring to/from time series, and handling missing 
data is required.


The approach for testing is to use actual time series data that are similar enough
 to demonstrate relationships, but different enough to allow for visual inspection 
of the time series and statistics.  The overall test process is as follows:


1) Create test data time series files from State of Colorado's HydroBase database.
   The full time series are written for the period and each month.

2) Create an Excel spreadsheet that implements the same logic using the same time series.

3) Basic TSTool tests are run to validate the analysis and filling, and the results are compared to the Excel results from the previous step, to a specified precision.

4) Variations on the tests are implemented to test various FillRegression() parameters, with appropriate parameter values being used based on the test data files (no need to regenerate test data).


-----------------------------------------------------------------------------------


1. CREATE TEST DATA


Run the following command files ONLY when there is a need to regenerate the
monthly data (should not be a need):


Month: Setup_CreateStreamflowMonthFromHydroBase.TSTool

       This creates a DateValue file for the period.

Day:   Setup_CreateStreamflowMonthFromHydroBase.TSTool

	  This creates a DateValue file for the period.


-----------------------------------------------------------------------------------


2. CREATE EXCEL SPREADSHEET WITH SAME LOGIC

The spreadsheets already exist in the ExpectedResults folder; they are named with the convention (test name)_excel.xlsx. Further details on what is contained within them and how to use them is contained within the file itself.


-----------------------------------------------------------------------------------


3. RUN TSTOOL COMMAND FILES TO TEST TSTool


TSTool is tested in the normal fashion by running a TSTool command file to generate
 files in "Results" and compare with files in "ExpectedResults". The command files in this folder all run tests, each described in the file itself.
