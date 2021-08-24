# ConfigureLogging #

The `ConfigureLogging` command is somewhat difficult to test with automated tests.
Additional work is needed.

A simple way to test is to use the command with StartLogEnabled=False when running 
a test suite and conform that all logging goes to the main log file.
