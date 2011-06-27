[Product]

MainTitleString = "Cache la Poudre River at Canyon Mouth"
ProductType = "Graph"
TotalHeight = "400"
TotalWidth = "600"

[SubProduct 1]

GraphType = "Line"
LeftYAxisIgnoreUnits = "false"
MainTitleString = ""
SubTitleString = "Stage"

[Data 1.1]

TSID = "CLAFTCCO.DWR.GAGE_HT.Irregular"

[Annotation 1.1]

ShapeType = "Line"
Order = "BehindData"
XAxisSystem = "Percent"
LineStyle = "Solid"
LineWidth = "2"
Points = "0,7.5,100,7.5"

[Annotation 1.2]

ShapeType = "Text"
XAxisSystem = "Percent"
Point = "0,7.5"
Text = "Flood Stage: 7.5'"
TextPosition = "UpperRight"

[SubProduct 2]

GraphType = "Line"
SubTitleString = "Streamflow"
LayoutYPercent = ""

[Data 2.1]

TSID = "CLAFTCCO.DWR.DISCHRG.Irregular"
