#!/bin/sh

# Run the compiled executable by passing all the arguments
# - this can be used to test running a script

scriptFolder=$(cd $(dirname "$0") && pwd)
${scriptFolder}/testprog-linux $@
