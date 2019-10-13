#!/bin/sh

# Run the test program to visually confirm that it is working
# - this should be used periodically if the program is modified

# Determine the operating system that is running the script
# - mainly care whether Cygwin
checkOperatingSystem()
{
	if [ ! -z "${operatingSystem}" ]; then
		# Have already checked operating system so return
		return
	fi
	operatingSystem="unknown"
	os=`uname | tr [a-z] [A-Z]`
	case "${os}" in
		CYGWIN*)
			operatingSystem="cygwin"
			;;
		LINUX*)
			operatingSystem="linux"
			;;
		MINGW*)
			operatingSystem="mingw"
			;;
	esac
	echo "operatingSystem=$operatingSystem (used to check for Cygwin and filemode compatibility)"
}

# Entry point to script

# Determine the operating system (Linux variant)
checkOperatingSystem

# Get the location where this script is located since it may have been run from any folder
scriptFolder=$(cd $(dirname "$0") && pwd)

if [ "$operatingSystem" = "linux" ]; then
	testprog="$scriptFolder/testprog-linux"
fi

# ---- Start exit code options ------------------------------------------

echo ""
echo "Test specifying exit code 9"
${testprog} --exitcode 9
exitCode=$?
if [ "$exitCode" -eq 9 ]; then
	echo "Exitcode $exitCode is as expected"
else
	echo "Exitcode $exitCode is NOT as expected"
fi

echo ""
echo "Test specifying exit code 99 (using environment variable)"
export TEST_EXIT_CODE="99"
${testprog} --exitcodeenv TEST_EXIT_CODE
exitCode=$?
if [ "$exitCode" -eq 99 ]; then
	echo "Exitcode $exitCode (using environment variable) is as expected"
else
	echo "Exitcode $exitCode (using environment variable) is NOT as expected"
fi

# ---- End exit code options --------------------------------------------

# ---- Start input and output file options ------------------------------

echo ""
echo "Test specifying input and output files (output below)"
inputFile="${scriptFolder}/../Data/input.txt"
outputFile="${scriptFolder}/../Results/testprog-out.txt"
${testprog} --inputfile "$inputFile" --outputfile "$outputFile"
cat "$outputFile"

echo ""
echo "Test specifying input and output files (using environment variables, output below)"
inputFile="${scriptFolder}/../Data/input.txt"
outputFile="${scriptFolder}/../Results/testprog-out.txt"
export TEST_INPUT_FILE="$inputFile"
export TEST_OUTPUT_FILE="$outputFile"
${testprog} --inputfileenv "$TEST_INPUT_FILE" --outputfileenv "$TEST_OUTPUT_FILE"
cat "$outputFile"

# ---- End input and output file options --------------------------------

# ---- Start stderr options ---------------------------------------------
# - redirect stdout to null because expect to only see stderr

echo ""
echo "Test specifying stderr file (output below)"
stderrFile="${scriptFolder}/../Data/stderr.txt"
${testprog} --stderrfile "$stderrFile" > /dev/null

echo ""
echo "Test specifying stderr file (using environment variable, output below)"
stderrFile="${scriptFolder}/../Data/stderr.txt"
export TEST_STDERR_FILE="$stderrFile"
${testprog} --stderrfileenv "TEST_STDERR_FILE" > /dev/null

# ---- End stderr options -----------------------------------------------

# ---- Start stdout options ---------------------------------------------
# - redirect stderr to null because expect to only see stdout

echo ""
echo "Test specifying stdout file (output below)"
stdoutFile="${scriptFolder}/../Data/stdout.txt"
${testprog} --stdoutfile "$stdoutFile" 2> /dev/null

echo ""
echo "Test specifying stdout file (using environment variable, output below)"
stdoutFile="${scriptFolder}/../Data/stdout.txt"
export TEST_STDOUT_FILE="$stdoutFile"
${testprog} --stdoutfileenv "TEST_STDOUT_FILE" 2> /dev/null

# ---- End stdout options -----------------------------------------------
