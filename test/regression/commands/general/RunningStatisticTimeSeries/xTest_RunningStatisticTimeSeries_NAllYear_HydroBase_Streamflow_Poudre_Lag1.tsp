[Product]

ProductType = "Graph"
TotalWidth = "600"
TotalHeight = "400"
MainTitleString = "Cache La Poudre at Canyon Mouth"

[SubProduct 1]

GraphType = "Line"
LeftYAxisTitleString = ""
LayoutYPercent = ""

[Data 1.1]

TSAlias = "06752000-Streamflow-Year"
Color = "Gray"
LineWidth = 2

[SubProduct 2]

TitleString = "Lag 1 Autocorrelation (relationship to previous year)"
GraphType = "Line"
LeftYAxisTitleString = ""
LayoutYPercent = ""

[Data 2.1]

TSID = "06752000.DWR.Streamflow-Running-Lag-1AutoCorrelation.Year~HydroBase"
TSAlias = "06752000-Streamflow-Year-Lag1AutoCorrelation"
LineWidth = 2
