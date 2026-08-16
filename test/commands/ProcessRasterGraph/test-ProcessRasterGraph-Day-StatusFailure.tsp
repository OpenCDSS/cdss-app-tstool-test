# Use invalid time series alias to force an error.

[Product]

MainTitleString = "test-ProcessRasterGraph-Day-StatusFailure"
ProductType = "Graph"
TotalWidth = "900"
TotalHeight = "600"

[SubProduct 1]

GraphType = "Raster"
LayoutYPercent = ""

[Data 1.1]

TSAlias = "x-Alias"
