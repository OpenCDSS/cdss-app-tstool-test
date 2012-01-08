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
data is required.  Initial testing has been performed on monthly data; however, more
complete testing on other intervals is needed to fully validate the software.

The approach for testing is to use actual time series data that are similar enough
to demonstrate relationships, but different enough to allow for visual inspection
of the time series and statistics.  The overall test process is as follows:

1) Create test data time series files from State of Colorado's HydroBase database.
   The full time series are written as well as comma-separated-value (CSV) files
   for the period and each month.
2) Using the CSV time series data files, generate expected results using Python
   scripts that implement the core FillRegression() logic.  The NumPy and SciPy
   Python modules are used to perform the statistics on the simple
   arrays, whereas TSTool computes the values internally.  The Python script
   outputs its results as CSV files, including a file containing the dependent and
   independent time series identifiers and the regression analysis statistics.
3) Basic TSTool tests are run to validate the analysis and filling, and the results are
   compared to the Python results from the previous step, to a specified precision.
4) Variations on the tests are implemented to test various FillRegression() parameters,
   with appropriate parameter values being used based on the test data files (no need
   to regenerate test data).

-----------------------------------------------------------------------------------

1. CREATE TEST DATA

Run the following command files ONLY when there is a need to regenerate the
monthly data (should not be a need):

Month: Setup_CreateStreamflowMonthFromHydroBase.TSTool
       This creates a DateValue file and also CSV files for the period and each month.
Day:   TODO - should be able to use the daily data for the same stations
Year:  TODO - could aggregate the monthly data but may be too much missing

TODO - need to include Mixed Station Model data here if it is easier or appropriate,
rather than doing all the testing in the FillMixedStation() command tests.

-----------------------------------------------------------------------------------

2. RUN PYTHON SCRIPTS TO CREATE EXPECTED RESULTS

Run the following Python scripts to use the input from Step 1 to create the expected
results.  The RunPython() command is used in the TSTool test to compare the Python
"ExpectedResults" files to the TSTool "Results" files.

TODO - figure out whether the Python scripts create ExpectedResults only for the
core functionality or all parameter combinations.

Month data, one equation - called in xxxxx
Month data, monthly equations - called in xxxxx

The Python configuration that was used to develop the tests is as follows:

C Python 2.5
NumPy 1.6.1
SciPy 0.10.0

TODO - explain the Excel validation (what is the extent of this validation?)

-----------------------------------------------------------------------------------

3. RUN TSTOOL COMMAND FILES TO TEST TSTool

TSTool is tested in the normal fashion by running a TSTool command file to generate
files in "Results" and compare with files in "ExpectedResults".  The following
command files run the tests:

Month data, one equation - xxxxx
Month data, monthly equations - xxxxx
