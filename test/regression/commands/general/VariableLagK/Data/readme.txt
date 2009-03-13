
The following tests were run using mcp3 to generate the output data for testing purposes.
The LagK.mcp3 was used to generate the output. If the tests need to be re-generated for
some reason, copied the input file to:
/projects/nwrfc_2008/calb/input/mcp3/decks/nwrfc/2008/TSToolLagK/LagK.mcp3
and the Streamflow.SQIN time series to:
/projects/nwrfc_2008/calb/data/area_ts/TSToolLagK/Streamflow.SQIN


Input streamflow for all cases: 
Streamflow.SQIN

The data are presented as:
Lag1, Q1, Lag2, Q2
K1, Q1, K2, Q2
if only one value is on a line, it is constant Lag or k

All units are METRIC--i.e. hours for the Lag and K parameters, and CMS for the Q parameters.
The one exception is with the ENGLISH_UNITS example--Q units are CFS in this case.


FIXED_LAG_NO_K.SQIN
     36.
      0.

NO_LAG_FIXED_K.SQIN
      0.
     22.

FIXED_LAG_AND_K.SQIN
     36.
     22.

VAR_LAG_NO_K.SQIN
    24.0   200.0    12.0  600.00     9.0  1500.0    42.0  3000.0
      0.

NO_LAG_VAR_K.SQIN
      0.
    24.0   200.0    12.0  600.00     9.0  1500.0    42.0  3000.0

VAR_LAG_AND_K.SQIN
    24.0   200.0    12.0  600.00     9.0  1500.0    42.0  3000.0
    24.0   200.0    12.0  600.00     9.0  1500.0    42.0  3000.0

ENGLISH_UNITS.SQIN 
(specified english units in the header information--Lag (hrs), Q (cfs), K (hrs), Q (cfs)
    36.0 10000.0    12.0 50000.0
     9.0 20000.0    24.0 60000.0

SMALL_K.SQIN
(The following should round the K value from 1.0 hours to 0.0 hours--when K < 0.5*interval)
     36.
      1.

Converted to 3 hour interval using CHANGE-T; the output of the CHANGE-T operation is:
3HR_INPUT.SQIN
Then routed the 3 hour time series:

3HR_VAR_LAG_K.SQIN
    24.0   200.0    12.0  600.00     9.0  1500.0    42.0  3000.0
    24.0   200.0    12.0  600.00     9.0  1500.0    42.0  3000.0
