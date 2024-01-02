[Product]

ProductType = "Graph"
TotalWidth = "600"
TotalHeight = "400"

[SubProduct 1]

GraphType = "Line"
RightYAxisGraphType = "None"
RightYAxisIgnoreUnits = "false"

MainTitleString = "Line Graph - each time series uses the default LineConnectType"

[Data 1.1]

#TSID = "usgs:06752000.DWR.Streamflow-Avg.Day"
TSAlias = "Connect"

[Data 1.2]

#TSID = "usgs:06752000.DWR.Streamflow-Avg.Day"
TSAlias = "StepUsingValue"

[Data 1.3]

#TSID = "usgs:06752000.DWR.Streamflow-Avg.Day"
TSAlias = "StepUsingNextValue"
