[Product]

ProductType = "Graph"
TotalWidth = "600"
TotalHeight = "400"
MainTitleString = "Colorado River Near Kremmling"

[SubProduct 1]

GraphType = "Line"
LeftYAxisTitleString = ""
LayoutYPercent = ""
LeftYAxisLabelPrecision = 0

[Data 1.1]

TSAlias = "09058000-Streamflow-Year"
Color = "Gray"
LineWidth = 2

[SubProduct 2]

TitleString = "Lag 1 Autocorrelation (relationship to previous year)"
GraphType = "Line"
LeftYAxisTitleString = ""
LayoutYPercent = ""

[Data 2.1]

TSID = "09058000.USGS.Streamflow-Running-Lag-1AutoCorrelation.Year~HydroBase"
TSAlias = "09058000-Streamflow-Year-Lag1AutoCorrelation"
LineWidth = 2
