[Product]

ProductType = "Graph"
TotalWidth = "600"
TotalHeight = "400"
MainTitleString = "Colorado River Near Kremmling"
SubTitleString = "Running Statistics (use all previous annual values)"

[SubProduct 1]

GraphType = "Line"
LayoutYPercent = ""
LeftYAxisLabelPrecision = 0

[Data 1.1]

TSID = "09058000.USGS.Streamflow-Running-Mean.Year~HydroBase"
TSAlias = "09058000-Streamflow-Year"
LineWidth = 2
Color = Gray

[Data 1.2]

TSID = "09058000.USGS.Streamflow-Running-Mean.Year~HydroBase"
TSAlias = "09058000-Streamflow-Year-Mean"
LineWidth = 2
Color = Black

[Data 1.3]

TSID = "09058000.USGS.Streamflow-Running-Median.Year~HydroBase"
TSAlias = "09058000-Streamflow-Year-Median"
LineWidth = 2
Color = Green

[Data 1.4]

TSID = "09058000.USGS.Streamflow-Running-Max.Year~HydroBase"
TSAlias = "09058000-Streamflow-Year-Max"
LineWidth = 2
Color = Blue

[Data 1.5]

TSID = "09058000.USGS.Streamflow-Running-Min.Year~HydroBase"
TSAlias = "09058000-Streamflow-Year-Min"
LineWidth = 2
Color = Red
