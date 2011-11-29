[Product]

ProductType = "Graph"
TotalWidth = "600"
TotalHeight = "400"
MainTitleString = "SIM24 (RUEIDI RES INFLOW) Exceedance Probabilities"
SubTitleString = "Using Historical Years 1976 - 2003"

[SubProduct 1]

GraphType = "Bar"
BarPosition = "CenteredOnDate"
BarOverlap = "True"
LayoutYPercent = ""

[Data 1.1]

TSID = "SIM24.NWSRFS.SQME-10%.24Hour"
TSAlias = "ExceedanceProbability10"
FlaggedDataSymbolStyle = ""
LineWidth = "0"

[Data 1.2]

TSID = "SIM24.NWSRFS.SQME-30%.24Hour"
TSAlias = "ExceedanceProbability30"

[Data 1.3]

TSID = "SIM24.NWSRFS.SQME-50%.24Hour"
TSAlias = "ExceedanceProbability50"

[Data 1.4]

TSID = "SIM24.NWSRFS.SQME-70%.24Hour"
TSAlias = "ExceedanceProbability70"

[Data 1.5]

TSID = "SIM24.NWSRFS.SQME-90%.24Hour"
TSAlias = "ExceedanceProbability90"
