############################################################
#
# Determine Student T Quantile
#
# Based on ALGORITHM 396 - Student T-Quantiles
#       G.W. Hill (1970)
#       Communications of the ACM
#       Volume 13 / Number 10 / October, 1970
#
############################################################

from scipy.stats import norm
import math

def Student_T_quantile (p,n):
    # convert one sided exceedence probability to confindence interval
    sign = 1
    if p < 0.5:
        sign = -1
    p = 2 * p
    if p > 1:
        p = 2.0 * (1.0 - p/2)
        
    halfPi = math.pi/2
    # For n = 1 and n = 2, an exact value of t can be calculated
    if n == 1:
        p = p * halfPi
        t = math.cos(p)/math.sin(p)
    elif n == 2:
        t = math.sqrt(2.0/(p*(2.0-p))-2.0)
    else:
        a = 1.0/(n-0.5)
        b = 48.0/math.pow(a,2)
        c =((20700*a/b-98)*a-16) * a + 96.36
        d = ((94.5/(b+c)-3.0)/b+1.0) * math.sqrt(a*halfPi) * n
        x = d * p
        y = math.pow(x,(2.0/n))
        if y > 0.05 + a:
            x =norm.ppf(p*0.5)
            y = math.pow(x,2)
            if n < 5:
                c = c + 0.3 * (n-4.5) * (x+0.6)
            c = (((0.05*d*x-5.0)*x-7.0)*x-2.0) * x + b + c
            y = (((((0.4*y+6.3)*y+36.0)*y+94.5)/c-y-3.0)/b+1.0)*x
            y = a * math.pow(y,2)
            if y > 0.002:
                y = math.exp(y) - 1.0
            else:
                y = 0.5 * math.pow(y,2) + y
        else:
            y = ((1.0/(((n+6.0)/(n*y)-0.089*d-0.822)*(n+2.0)*3.0)+0.5/(n+4.0))*y-1.0) * (n+1.0)/(n+2.0) + 1.0/y
        t = math.sqrt(n*y)
    return sign*t

