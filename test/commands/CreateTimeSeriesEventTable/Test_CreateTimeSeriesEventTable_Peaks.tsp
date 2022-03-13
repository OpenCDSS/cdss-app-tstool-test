# Graph template to compare training raw and expected data.
# @template

[Product]

ProductType = "Graph"
TotalWidth = "900"
TotalHeight = "600"
MainTitleString = "Run ${RunId}"
SubTitleString = "Expected modifier: (${Modifier})"

[SubProduct 1]

GraphType = "Line"
LeftYAxisLabelPrecision = "4"
RightYAxisGraphType = "None"
RightYAxisIgnoreUnits = "false"
LayoutYPercent = ""

[Data 1.1]

TSID = "${RunId}..value.IRREGULAR"
TSAlias = "${RunId}-raw"

[Data 1.2]

TSID = "${RunId}..Start Height.IRREGULAR"
TSAlias = "${RunId}-expected"
DataLabelFormat = "%q"
DataLabelPosition = "UpperRight"
LineStyle = "None"
SymbolSize = "5"
SymbolStyle = "Circle-Filled"

[Data 1.3]

TSID = "${RunId}..EventExtremeValue.IRREGULAR"
TSAlias = "${RunId}-estimated"
DataLabelFormat = "%q"
DataLabelPosition = "UpperRight"
LineStyle = "None"
SymbolSize = "5"
SymbolStyle = "Circle-Filled"
