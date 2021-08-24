[Product]

ProductType = "Graph"
TotalWidth = "600"
TotalHeight = "400"
MainTitleString = "South Platte River Near Kersey"

[SubProduct 1]

GraphType = "Line"
LeftYAxisTitleString = ""
LayoutYPercent = ""

[Data 1.1]

TSAlias = "06754000-Streamflow-Year"
Color = "Gray"
LineWidth = 2

[SubProduct 2]

TitleString = "Lag 1 Autocorrelation (relationship to previous year)"
GraphType = "Line"
LeftYAxisTitleString = ""
LayoutYPercent = ""

[Data 2.1]

TSID = "06754000.DWR.Streamflow-Running-Lag-1AutoCorrelation.Year~HydroBase"
TSAlias = "06754000-Streamflow-Year-Lag1AutoCorrelation"
LineWidth = 2
