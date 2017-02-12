[Product]

ProductType = "Graph"
TotalWidth = "600"
TotalHeight = "400"
ShowDrawingAreaOutline = "false"
MainTitleString = "Test Product with 2 Graphs, each with Right Axis"

[SubProduct 1]

GraphType = "Bar"
BarOverlap = "False"
BarPosition = "LeftOfDate"
LeftYAxisLabelPrecision = 0
LeftYAxisTitleString = "Streamflow (CFS)"
LeftYAxisTitlePosition = "LeftOfAxis"
LeftYAxisTitleRotation = "270"
LeftYAxisTitleFontStyle = "Bold"
RightYAxisGraphType = "Line"
RightYAxisTitlePosition = "RightOfAxis"
RightYAxisTitleRotation = "90"
RightYAxisTitleFontStyle = "Bold"
RightYAxisTitleString = "Temperature (DEGF)"
RightYAxisIgnoreUnits = "false"
RightYAxisMajorTickColor = "black"

[Data 1.1]

TSID = "ts1..MyData.Day"
TSAlias = "ts1"

[Data 1.2]

TSID = "ts2..MyData.Day"
TSAlias = "ts2"
YAxis = "Right"

[SubProduct 2]

GraphType = "Bar"
BarOverlap = "False"
BarPosition = "LeftOfDate"
LeftYAxisLabelPrecision = 0
LeftYAxisTitleString = "Streamflow (CFS)"
LeftYAxisTitlePosition = "LeftOfAxis"
LeftYAxisTitleRotation = "270"
LeftYAxisTitleFontStyle = "Bold"
RightYAxisGraphType = "Line"
RightYAxisTitlePosition = "RightOfAxis"
RightYAxisTitleRotation = "90"
RightYAxisTitleFontStyle = "Bold"
RightYAxisTitleString = "Temperature (DEGF)"
RightYAxisIgnoreUnits = "false"
RightYAxisMajorTickColor = "black"

[Data 2.1]

TSID = "ts3..MyData.Day"
TSAlias = "ts3"

[Data 2.2]

TSID = "ts4..MyData.Day"
TSAlias = "ts4"
YAxis = "Right"
