############################################################
#
# Read CSV file containing values
#
############################################################

import csv
import re

def Read_CSV (fileName):

    fileOpen = open(fileName, 'rb')
    data = csv.reader(fileOpen)

    Flow=[]
    dataLine = data.next()
    # Printing the sum and count is done to track down Java vs. Python precision issues
    sum = 0.0
    count = 0
    printSum = False
    while dataLine != None:
        m1 = re.search("#", dataLine[0])
# Find TS name
        m2 = re.search("DateTime", dataLine[0])
        if m1 == None and m2 != None:
            TSName = dataLine[1]
# For Daily Data
#        m3 = re.search("\d{4}-\d{2}-\d{2}", dataLine[0])
# For Monthly Data
        m3 = re.search("\d{4}-\d{2}", dataLine[0])
        if m1 == None and m3 != None:
            if dataLine[1]!='':
                Flow.append(float(dataLine[1]))
                sum = sum + float(dataLine[1])
                count = count + 1
            else:
                Flow.append(-999.0)
            if ( printSum == True ):
                print dataLine[0] + " " + str(sum)
        try:
            dataLine = data.next()
        except:
            break

    if ( (count > 0) and (printSum == True) ):
        print "mean=" + str(sum/float(long(count)))

    fileOpen.close()
    return TSName, Flow

