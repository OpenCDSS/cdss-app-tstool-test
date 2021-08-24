#!/bin/bash
#
# This script converts the NRCS-SnowCourse-JoeWright-historical.txt
# file into a format that can be processed by TSTool.
# The Python script that is has been used in the past.
# A copy of the script is made here to facilitate conversion of data.
#
# Only need to run once to set up the test

python snowcourse2csv.py inputFile=NRCS-SnowCourse-JoeWright-historical.txt outputFile=NRCS-SnowCourse-JoeWright-historical.csv
