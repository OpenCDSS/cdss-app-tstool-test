/* Only read specific columns because the HydroBase design changes over time. */
select meas_num, structure_num, quality, irr_year, fdu, ldu, dwc, maxq, maxq_date, nobs,
amt_nov, amt_dec, amt_jan, amt_feb, amt_mar, amt_apr, amt_may, amt_jun, amt_jul, amt_aug, amt_sep, amt_oct from vw_CDSS_AnnualAmt where meas_num =
(select meas_num from vw_CDSS_StructureStructMeasType
where wd = 1 and id = 501 and meas_type = 'DivTotal' and time_step='Annual')
and irr_year >= 1970 and irr_year < 1980 order by irr_year
