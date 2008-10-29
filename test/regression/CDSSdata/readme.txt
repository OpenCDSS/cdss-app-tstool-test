This folder matches the /CDSS/data folder, which contains CDSS basin data sets.
Because these data sets are so large and change over time, it does not make
sense to include the full data sets in the repository for testing.  Also, the
tests often generate warnings or failures because the modelers do not fully
clean up command files, HydroBase changes, etc.  Therefore, testing usually
occurs on a local or network drive outside the development sandbox.

The folder structure here mimics that of local testing, but saves the critical
command files and test documentation.  The documentation and command files are
typically provided to the State and modelers.  The command files can also be
copied to new verification folders, to facilitate testing of new data sets.

In the future, it may be useful to write a script to process a data set and
generate the command file.
