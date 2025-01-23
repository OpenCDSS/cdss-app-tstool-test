# Use invalid time series alias to force an error.

[Product]

ProductType = "Graph"
TotalWidth = "900"
TotalHeight = "600"
MainTitleString = "test-ProcessRasterGraph-Day"

[SubProduct 1]

GraphType = "Raster"
LayoutYPercent = ""

[Data 1.1]

TSAlias = "x-Alias"
