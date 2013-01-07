[Product]

ProductType = "Graph"
TotalWidth = "600"
TotalHeight = "400"
MainTitleString = "Cache La Poudre River at Mouth of Canyon"
SubTitleString = "Running Statistics (use all previous values)"

[SubProduct 1]

GraphType = "Line"
LayoutYPercent = ""
LeftYAxisLabelPrecision = 0

[Data 1.1]

TSID = "06752000.DWR.Streamflow-Running-Mean.Year~HydroBase"
TSAlias = "06752000-Streamflow-Year"
LineWidth = 2
Color = Gray

[Data 1.2]

TSID = "06752000.DWR.Streamflow-Running-Mean.Year~HydroBase"
TSAlias = "06752000-Streamflow-Year-Mean"
LineWidth = 2
Color = Black

[Data 1.3]

TSID = "06752000.DWR.Streamflow-Running-Median.Year~HydroBase"
TSAlias = "06752000-Streamflow-Year-Median"
LineWidth = 2
Color = Green

[Data 1.4]

TSID = "06752000.DWR.Streamflow-Running-Max.Year~HydroBase"
TSAlias = "06752000-Streamflow-Year-Max"
LineWidth = 2
Color = Blue

[Data 1.5]

TSID = "06752000.DWR.Streamflow-Running-Min.Year~HydroBase"
TSAlias = "06752000-Streamflow-Year-Min"
LineWidth = 2
Color = Red
