select * from vw_CDSS_AnnualAmt where meas_num =
(select meas_num from vw_CDSS_StructureStructMeasType
where wd = 1 and id = 501 and meas_type = 'DivTotal' and time_step='Annual')
and irr_year >= 1970 and irr_year < 1980 order by irr_year
