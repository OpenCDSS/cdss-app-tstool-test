#!/bin/bash

# Main entry point for the script.

scriptFolder=$(cd $(dirname "$0") && pwd)

repoFolder=$(dirname ${scriptFolder})
testFolder="${repoFolder}/test"
testCommandsFolder="${testFolder}/commands"

debug="false"

# List command files that match typical extensions (TSTool and tstool).
# See: https://stackoverflow.com/questions/1133698/using-find-to-locate-files-that-match-one-of-multiple-patterns
find ${testCommandsFolder} -regex ".*\.\(TSTool\|tstool\)$" | while read -r filepath;
  do
    if [ "${debug}" = "true" ]; then
      echo "Checking: ${filepath}"
    fi
    # Find command line that turns debug on.
    debugCount=$(grep SetDebugLevel ${filepath} | grep -v '#' | wc -l)
    if [ ${debugCount} -gt 0 ]; then
      echo "  Has ${debugCount} SetDebugLevel: ${filepath}"
    else
      continue
    fi
    # Need to have the following as the last command:
    #  SetDebugLevel(LogFileLevel=0)
    #  SetDebugLevel(ScreenLevel=0)
    offCount=$(grep SetDebugLevel ${filepath} | grep -v '#' | tail -1 | grep 'LogFileLevel=0' | wc -l)
    if [ ${offCount} -ne 1 ]; then
      echo "  Does not include ending LogFileLevel=0"
    fi
    offCount=$(grep SetDebugLevel ${filepath} | grep -v '#' | tail -1 | grep 'ScreenLevel=0' | wc -l)
    if [ ${offCount} -ne 1 ]; then
      echo "  Does not include ending ScreenLevel=0"
    fi
  done
