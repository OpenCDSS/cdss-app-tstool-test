[Product]

ProductType = "Graph"
TotalWidth = "600"
TotalHeight = "400"

[SubProduct 1]

GraphType = "Line"
RightYAxisGraphType = "None"
RightYAxisIgnoreUnits = "false"

MainTitleString = "Line Graph - each time series uses a different LineConnectType"

[Data 1.1]

TSAlias = "Connect"

[Data 1.2]

TSAlias = "StepUsingValue"
LineConnectType = "StepUsingValue"

[Data 1.3]

TSAlias = "StepUsingNextValue"
LineConnectType = "StepUsingNextValue"
