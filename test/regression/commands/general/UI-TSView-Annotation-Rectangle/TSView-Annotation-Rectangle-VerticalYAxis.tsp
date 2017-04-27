[Product]

ProductType = "Graph"
TotalWidth = "800"
TotalHeight = "600"
MainTitleString = "Cache la Poudre River at Fort Collins, CO"
ShowDrawingAreaOutline = "False"

[SubProduct 1]

GraphType = "Bar"
LayoutYPercent = "30"
LeftYAxisDirection = "Reverse"
LeftYAxisTitleFontStyle = "Bold"
LeftYAxisTitlePosition = "LeftOfAxis"
LeftYAxisTitleRotation = "270"
RightYAxisIgnoreUnits = "false"
LeftYAxisTitleString = "Precipitation (in)"

[Data 1.1]

TSID = "COOP:053005.ACIS.pcpn.Day~RCC-ACIS"
Color = "Blue"
FlaggedDataSymbolStyle = ""
LineWidth = "0"

[Annotation 1.1]

ShapeType = "Rectangle"
AnnotationID = "Heavy Precipitation"
Color = "Yellow"
Order = "BehindAxes"
XAxisSystem = "Percent"
Points = "0,1,100,20"

[Annotation 1.2]

ShapeType = "Text"
AnnotationID = "Heavy Precipitation Label"
Color = "Black"
FontStyle = "Bold"
FontSize = "14"
Order = "BehindData"
XAxisSystem = "Percent"
Point = "0,1"
Text = "Heavy precipitation = 1 in/hour"
TextPosition = "LowerRight"

[SubProduct 2]

GraphType = "Area"
LayoutYPercent = "70"
LeftYAxisTitlePosition = "LeftOfAxis"
LeftYAxisTitleRotation = "270"
LeftYAxisLabelPrecision = "0"
LeftYAxisTitleFontStyle = "Bold"
RightYAxisIgnoreUnits = "false"
LeftYAxisTitleString = "Streamflow (cfs)"

[Data 2.1]

TSID = "06752260.USGS.Streamflow.Day~HydroBase"
Color = "Blue"
FlaggedDataSymbolStyle = ""
LineWidth = "0"

[Annotation 2.1]

ShapeType = "Rectangle"
AnnotationID = "Near Flood Stage"
Color = "Yellow"
Order = "BehindAxes"
XAxisSystem = "Percent"
Points = "0,3000,100,4000"

[Annotation 2.2]

ShapeType = "Text"
AnnotationID = "Near Flood Stage Label"
Color = "Black"
FontStyle = "Bold"
FontSize = "14"
Order = "BehindData"
XAxisSystem = "Percent"
Point = "0,3000"
Text = "Near flood stage = 3000 cfs"
TextPosition = "UpperRight"

[Annotation 2.3]

ShapeType = "Rectangle"
AnnotationID = "Minor Flooding"
Color = "Orange"
Order = "BehindAxes"
XAxisSystem = "Percent"
Points = "0,4000,100,5000"

[Annotation 2.4]

ShapeType = "Text"
AnnotationID = "Minor Flooding Label"
Color = "Black"
FontStyle = "Bold"
FontSize = "14"
Order = "BehindData"
XAxisSystem = "Percent"
Point = "0,4000"
Text = "Minor flooding = 4000 cfs"
TextPosition = "UpperRight"

[Annotation 2.5]

ShapeType = "Rectangle"
AnnotationID = "Moderate Flooding"
Color = "Red"
Order = "BehindAxes"
XAxisSystem = "Percent"
Points = "0,5000,100,6000"

[Annotation 2.6]

ShapeType = "Text"
AnnotationID = "Moderate Flooding Label"
Color = "Black"
FontStyle = "Bold"
FontSize = "14"
Order = "BehindData"
XAxisSystem = "Percent"
Point = "0,5000"
Text = "Moderate flooding = 5000 cfs"
TextPosition = "UpperRight"

[Annotation 2.7]

ShapeType = "Rectangle"
AnnotationID = "Major Flooding"
Color = "Magenta"
Order = "BehindAxes"
XAxisSystem = "Percent"
Points = "0,6000,100,10000"

[Annotation 2.8]

ShapeType = "Text"
AnnotationID = "Major Flooding Label"
Color = "Black"
FontStyle = "Bold"
FontSize = "14"
Order = "BehindData"
XAxisSystem = "Percent"
Point = "0,6000"
Text = "Major flooding = 6000 cfs"
TextPosition = "UpperRight"
