#
# Test command for running Python script from TSTool
#
import sys
import os
print "start of script"
print 'os.getcwd()="' + os.getcwd() + '"'
infile = None
outfile = None
if ( len(sys.argv) < 3 ):
    print "Error.  Expecting input file name as first command line argument, output file name as second."
    sys.exit(1)
else:
    infile = sys.argv[1]
    outfile = sys.argv[2]
    print 'Input file to process is "' + infile + '"'
    print 'Output file to create is "' + outfile + '"'

inf=open(infile,'r')
outf=open(outfile,'w')
for line in inf:
    outf.write("out: " + line)
inf.close()
outf.close()
print "end of script"
