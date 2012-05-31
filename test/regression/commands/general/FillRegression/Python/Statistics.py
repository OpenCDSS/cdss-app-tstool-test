############################################################
#
# Statistical routines for FillRegression
#
############################################################

import numpy
import scipy
import math

def regression_coef (x,y):
    std_x = numpy.std(x,ddof=1)
    std_y = numpy.std(y,ddof=1)
    r = numpy.corrcoef(x,y)[0,1]
    b = r * (std_y/std_x)
    a = numpy.mean(y) - (b * numpy.mean(x))
    return a, b, r, pow(r,2)

def overlapping (x,y, missingValue):
    x_filtered=[]
    x_n2=[]
    y_filtered=[]
    n2=0
    for i in range(0,len(x)):
        if x[i] != missingValue:
            if y[i] == missingValue:
                n2 = n2 + 1
                if x[i] != missingValue:
                    x_n2.append(x[i])
            if y[i] != missingValue:
                x_filtered.append(x[i])
                y_filtered.append(y[i])
    n1 = len(x_filtered)
    return x_filtered, x_n2, y_filtered, n1, n2

def statistics (x):
    Mean = numpy.mean(x)
    StDev = numpy.std(x,ddof=1)
    return Mean, StDev

def dependent_statistics (y, missingValue):
    y_filtered=[]
    for i in range(0,len(y)):
        if y[i] != missingValue:
            y_filtered.append(y[i])
    MeanY = numpy.mean(y_filtered)
    SY = numpy.std(y_filtered,ddof=1)
    NY = len(y_filtered)
    return MeanY, NY, SY

def calculate_Yest (x, a, b):
    Yest=[]
    for i in range(0,len(x)):
        value=a+(b*x[i])
        Yest.append(value)
    meanY1Est = numpy.mean(Yest)
    SY1Est = numpy.std(Yest,ddof=1)
    return Yest, meanY1Est, SY1Est

def RMSE (y, yest, n):
    sumOfSquare = 0
    for i in range(0,len(y)):
        sumOfSquare = sumOfSquare + pow((y[i]-yest[i]),2)
    RMSE = math.sqrt(sumOfSquare/n)
    return RMSE

def SEE (y, yest, n):
    sumOfSquare = 0
    for i in range(0,len(y)):
        sumOfSquare = sumOfSquare + pow((y[i]-yest[i]),2)
    SEE = math.sqrt(sumOfSquare/(n-2))
    return SEE

def SEP (x, SEE, n):
    SEP=[]
    meanX = numpy.mean(x)
    sumOfSquare = 0
    for i in range(0,len(x)):
        sumOfSquare = sumOfSquare + pow((x[i]-meanX),2)
    for i in range(0,len(x)):
        value = pow((x[i]-meanX),2)/sumOfSquare
        value = math.sqrt(1 + (1.0/n) + value) * SEE
        SEP.append(value)
    return SEP

def SESlope (x, y, yest, n):
    meanX = numpy.mean(x)
    sumOfSquareX = 0
    sumOfSquareY = 0
    for i in range(0,len(x)):
        sumOfSquareX = sumOfSquareX + pow((x[i]-meanX),2)
        sumOfSquareY = sumOfSquareY + pow((y[i]-yest[i]),2)
    SESlope = math.sqrt(sumOfSquareY/(n-2))/math.sqrt(sumOfSquareX)
    return SESlope

def TestScore (b, SE):
    if SE != 0:
        TestScore = b/SE
    else:
        TestScore = "inf"
    return TestScore

def LinearRegression (a, b, x):
    y=[]
    for i in range(0,len(x)):
        temp = a + (b*x[i])
        y.append(temp)
    return y

def Skew (x):
    # bias=False means DO correct for bias (use n - 1? as sample standard deviation, etc.?)
    skew = scipy.stats.skew(x, bias=False)
    return skew
