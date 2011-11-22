rem echo off
rem Run the python script that converts the MSM input and output files to STM format
rem This allows comparison of the MSM results in a standard format for verification
rem Replace the path to the script with that appropriate for the TSTool release

python C:\CDSS\TSTool-09.10.00beta\python\MixedStation\msm2stm.py fill-in.in
python C:\CDSS\TSTool-09.10.00beta\python\MixedStation\msm2stm.py fill-in.out
