[Product]

ProductType = "Graph"
TotalWidth = "600"
TotalHeight = "400"
MainTitleString = "Stacked Area Graph with Line on Top"

[SubProduct 1]

GraphType = "AreaStacked"
LeftYAxisLabelPrecision = "0"
RightYAxisGraphType = "None"
RightYAxisIgnoreUnits = "false"
LayoutYPercent = ""

[Data 1.1]

TSID = "ts1..MyData.Day"
TSAlias = "ts1"
FlaggedDataSymbolStyle = ""
LineWidth = "0"

[Data 1.2]

TSID = "ts2..MyData.Day"
TSAlias = "ts2"

[Data 1.3]

TSID = "ts3..MyData.Day"
TSAlias = "ts3"
Color = cyan
GraphType = "Line"
