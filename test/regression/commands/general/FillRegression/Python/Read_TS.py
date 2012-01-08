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
            else:
                Flow.append(-999)
        try:
            dataLine = data.next()
        except:
            break

    fileOpen.close()
    return TSName, Flow

