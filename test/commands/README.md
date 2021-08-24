# commands/general

These folders contain tests for each TSTool command,
where the folder name matches the command name.
Time series identifier (TSID) commands are in folders starting with `TSID` and include
the datastore name.

## Test Suites

Some commands are more difficult to test because they require special environment configuration
(such as access to a database), are slow, or are obsolete and therefore are kept around
only as historical artifact or example.
The command files for such tests are assigned to a test suite using the
`#@testSuite Name` comment.
The following table lists test suites that are used in the command files,
which are handled in the [`test-suites`](../test-suites/README.md) command files
(removed from general tests and can be run as a separate test suite).

| **Test Suite** | **Type** | **Description** |
| -- | -- | -- |
| `ReclamationHDB` | Datastore | Tests that can be used with `ReclamationHDB` datastore, requires access to an Oracle HDB database. This datastore may be split into a plugin in the future. |
| `RiversideDB` | Datastore | Tests that can be used with `RiversideDB` datastore, which requires access to SQL Serve database. This datasetore is no longer maintained with core TSTool code. |
| `MixedStationModel` | Command | Tests for the `FillMixedStation` command, which require significant data and are slow to test. The Mixed Station Model is also a separate program.  TSTool features and tests  need to be reviewed by modelers. |
