# compare-20200125-20200720

Tests to compare HydroBase versions 20200125 (old) and 20200720 (new).
The new database has some important changes, including:

* includes water class diversion records
* includes more views to directly access data without needing to use a stored procedure
* includes updated station time series tables

These tests use datastores for the old and new design.
The datastore configuration files are shown below for reference.
These files should be located in the users `.tstool/13/datastores` folder, or similar.

## HydroBase 20200125

```
# Configuration information for HydroBase database datastore, CDSS account.
# 20200125 version
#
# Using a datastore name of "HydroBase" will override the legacy
# HydroBase input type convention.  Transitioning to a HydroBase
# datastore allows new TSTool features to be used.
#
# The user will see the following when interacting with the datastore:
#
# Name - datastore identifier used in applications, for example as the
#     input type information for time series identifiers (usually a short string)
# Description - datastore description for reports and user interfaces (short phrase)
#
# The following are needed to make database connections in the software
#
# Type - must be HydroBaseDataStore
# DatabaseEngine - the database software (SqlServer is current standard)
# DatabaseServer - IP or string address for database server, with instance name
#                  (e.g., "localhost\CDSS" can be used for local computer)
# DatabaseName - database name used by the server (e.g., HydroBase_CO_20120722)
# SystemLogin - service account login (omit for default)
# SystemPassword - service account password (omit for default)
# Enabled - if True then datastore will be enabled when software starts, False to disable

# Change the following to True to enable the datastore
Enabled = True
Type = "HydroBaseDataStore"
Name = "HydroBase20200125"
Description = "HydroBase Datastore"
DatabaseEngine = "SqlServer"
# HydroBase SQL Server Express installation on local machine...
DatabaseServer = "localhost\CDSS"
#DatabaseName = "HydroBase_CO_20161220"
#DatabaseName = "HydroBase_CO_20180529"
DatabaseName = "HydroBase_CO_20200125"
# HydroBase on SQL Server server machine...
#DatabaseServer = "SomeMachine\CDSS"
#DatabaseName = "HydroBase"
```

## HydroBase 20200720

```
# Configuration information for HydroBase database datastore, CDSS account.
# 20200720 version
#
# Using a datastore name of "HydroBase" will override the legacy
# HydroBase input type convention.  Transitioning to a HydroBase
# datastore allows new TSTool features to be used.
#
# The user will see the following when interacting with the datastore:
#
# Name - datastore identifier used in applications, for example as the
#     input type information for time series identifiers (usually a short string)
# Description - datastore description for reports and user interfaces (short phrase)
#
# The following are needed to make database connections in the software
#
# Type - must be HydroBaseDataStore
# DatabaseEngine - the database software (SqlServer is current standard)
# DatabaseServer - IP or string address for database server, with instance name
#                  (e.g., "localhost\CDSS" can be used for local computer)
# DatabaseName - database name used by the server (e.g., HydroBase_CO_20120722)
# SystemLogin - service account login (omit for default)
# SystemPassword - service account password (omit for default)
# Enabled - if True then datastore will be enabled when software starts, False to disable

# Change the following to True to enable the datastore
Enabled = True
Type = "HydroBaseDataStore"
Name = "HydroBase20200720"
Description = "HydroBase Datastore"
DatabaseEngine = "SqlServer"
# HydroBase SQL Server Express installation on local machine...
DatabaseServer = "localhost\CDSS"
#DatabaseName = "HydroBase_CO_20161220"
#DatabaseName = "HydroBase_CO_20180529"
#DatabaseName = "HydroBase_CO_20200125"
DatabaseName = "HydroBase_CO_20200720"
# HydroBase on SQL Server server machine...
#DatabaseServer = "SomeMachine\CDSS"
#DatabaseName = "HydroBase"
```
