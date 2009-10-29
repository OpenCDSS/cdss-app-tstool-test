# Python script to generate contrived monthly data that demonstrates cutoffs

for i in 1, 2:
	f = open("monthts" + str(i) + ".dv","w")
	f.write("# Test monthly data with missing values at ends and 100 values\n")
	f.write("# Missing values will fill the period for data that are not specifically set\n")
	f.write("Delimiter   = \" \"\n")
	f.write("NumTS       = 1\n")
	f.write("TSID        = \"ts" + str(i) + "..Stremflow.Month\"\n")
	f.write("Alias       = \"\"\n")
	f.write("Description = \"test data " + str(i) + "\"\n")
	f.write("DataType    = \"\"\n")
	f.write("Units       = \"af\"\n")
	f.write("MissingVal  = -999.0000\n")
	f.write("Start       = 1895-01\n")
	f.write("End         = 2005-12\n")
	f.write("#EndHeader\n")
	f.write("Date \"ts" + str(i) + "..Streamflow.Month, af\"\n")

	for year in range(1901,2001):
		for month in range(1,13):
			month = '%02d' % month
			date = str(year) + "-" + str(month)
			if ( i == 1 ):
				# First time series has values that match counter
				value = str(year - 1900) + "." + str(month)
			else:
				# Second time series has values that match counter+10
				value = str(year - 1900 + 10) + "." + str(month)
			f.write(date + " " + value + "\n" ) 

	f.close()
