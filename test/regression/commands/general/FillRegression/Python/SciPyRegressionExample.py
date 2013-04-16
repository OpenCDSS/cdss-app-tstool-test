from scipy import stats
import numpy as np

x = np.random.random(10)
y = np.random.random(10)
slope, intercept, r_value, p_value, std_err = stats.linregress(x,y)

print 'p_value='+str(p_value)
