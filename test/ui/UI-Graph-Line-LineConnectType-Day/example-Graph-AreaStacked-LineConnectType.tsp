[Product]

ProductType = "Graph"
TotalWidth = "600"
TotalHeight = "400"

MainTitleString = "Stacked Area Graph - each time series uses a different LineConnectType"

[SubProduct 1]

GraphType = "AreaStacked"
RightYAxisGraphType = "None"
RightYAxisIgnoreUnits = "false"

[Data 1.1]

TSID = "usgs:06752000.DWR.Streamflow-Avg.Day"
TSAlias = "Connect"

[Data 1.2]

TSID = "usgs:06752000.DWR.Streamflow-Avg.Day"
TSAlias = "StepUsingValue"
LineConnectType = "StepUsingValue"

[Data 1.3]

TSID = "usgs:06752000.DWR.Streamflow-Avg.Day"
TSAlias = "StepUsingNextValue"
LineConnectType = "StepUsingNextValue"
