# Use a bad time series identifier to cause a failure.

#@template

[Product]

ProductType = "Graph"
TotalWidth = "600"
TotalHeight = "400"
MainTitleString = "Test_ProcessTSProduct_1"

[SubProduct 1]

GraphType = "Line"
RightYAxisGraphType = "None"
RightYAxisIgnoreUnits = "false"

[Data 1.1]

TSID = "x-MyLoc..MyData.Day"
TSAlias = "x-Alias"

[Annotation 1.1]

ShapeType = "Text"
AnnotationID = "Annotation1"
XAxisSystem = "Percent"
YAxisSystem = "Percent"
Point = "0,100"
Text = "Test data value = ${TestProperty} CFS"
TextPosition = "LowerRight"
