# TSID_ColoradoHydroBaseRest #

These are tests for the ColoradoHydroBaseRest web services.  Guidelines are as follows:

* Structure time series (DivTotal, RelTotal, WaterClass, etc.) are available in web services and HydroBase:
	+ Where possible, tests are implemented to compare web services and HydroBase local database,
	in order to provide an additional level of validation.
	+ Compare time series to a precision using `CompareTimeSeries` command.
* For telemetry stations, data are only available in web services:
	+ For daily data, use a period `2018-01-01` to `2018-03-15`
	+ For hourly data, use a period `2018-01-01 00` to `2018-01-03 12`
	+ For 15min data, use a period `2018-01-01 00:00` to `2018-01-02 01:00`
	+ Use longer periods to test leap year, focusing on `DISCHRG` data type.
	+ Use other periods depending on data availability.
	+ All known data type (parameter type) are tested,
	to provide examples and to provide opportunities to check units, missing data, etc.
* Well level time series are available in web services and HydroBase:
	+ Tests compare web services and HydroBase local database,
	in order to provide an additional level of validation.
