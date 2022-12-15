# ZZ-EndChecks

This command file checks the final state of the testing environment to make sure issues have not arisen:

*   Check the processor properties `DebugLevelLogFile` and `DebugLevelScreen` to make sure they are nonzero.
    Otherwise, a test may have left debug on, which may result in slow processing and large log files.
