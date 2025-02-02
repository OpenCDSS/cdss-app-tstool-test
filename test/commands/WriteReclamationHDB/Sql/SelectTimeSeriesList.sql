/*
Select distinct time series:
*/
select distinct HDB_OBJECTTYPE.OBJECTTYPE_ID, HDB_OBJECTTYPE.OBJECTTYPE_NAME, HDB_OBJECTTYPE.OBJECTTYPE_TAG,
 HDB_SITE.SITE_ID, HDB_SITE.SITE_NAME, HDB_SITE.SITE_COMMON_NAME,
 HDB_STATE.STATE_CODE,
 HDB_SITE.BASIN_ID, HDB_SITE.LAT, HDB_SITE.LONGI, HDB_SITE.HYDROLOGIC_UNIT, HDB_SITE.SEGMENT_NO, HDB_SITE.RIVER_MILE, HDB_SITE.ELEVATION,
 HDB_SITE.DESCRIPTION, HDB_SITE.NWS_CODE, HDB_SITE.SCS_ID, HDB_SITE.SHEF_CODE, HDB_SITE.USGS_ID, HDB_SITE.DB_SITE_CODE,
 HDB_DATATYPE.DATATYPE_NAME, HDB_DATATYPE.DATATYPE_COMMON_NAME, HDB_DATATYPE.PHYSICAL_QUANTITY_NAME,
 HDB_DATATYPE.AGEN_ID,
 HDB_UNIT.UNIT_COMMON_NAME,
 HDB_SITE_DATATYPE.SITE_DATATYPE_ID,
   min(R_HOUR.START_DATE_TIME), max(R_HOUR.START_DATE_TIME) from HDB_OBJECTTYPE 
   JOIN HDB_SITE on HDB_SITE.OBJECTTYPE_ID = HDB_OBJECTTYPE.OBJECTTYPE_ID
   JOIN HDB_SITE_DATATYPE on HDB_SITE.SITE_ID = HDB_SITE_DATATYPE.SITE_ID
   JOIN HDB_DATATYPE on HDB_DATATYPE.DATATYPE_ID = HDB_SITE_DATATYPE.DATATYPE_ID
   JOIN HDB_UNIT on HDB_DATATYPE.UNIT_ID = HDB_UNIT.UNIT_ID
   JOIN R_HOUR on R_HOUR.SITE_DATATYPE_ID = HDB_SITE_DATATYPE.SITE_DATATYPE_ID
   LEFT JOIN HDB_STATE on HDB_SITE.STATE_ID = HDB_STATE.STATE_ID
where
/* Uncomment if want specific site common name
(upper(HDB_SITE.SITE_COMMON_NAME) = 'AAA_DELETE')
*/
/* Uncomment if want specific data type
and (upper(HDB_DATATYPE.DATATYPE_COMMON_NAME) = 'FLOW')
*/
group by HDB_OBJECTTYPE.OBJECTTYPE_ID, HDB_OBJECTTYPE.OBJECTTYPE_NAME, HDB_OBJECTTYPE.OBJECTTYPE_TAG,
 HDB_SITE.SITE_ID, HDB_SITE.SITE_NAME, HDB_SITE.SITE_COMMON_NAME,
 HDB_STATE.STATE_CODE,
 HDB_SITE.BASIN_ID, HDB_SITE.LAT, HDB_SITE.LONGI, HDB_SITE.HYDROLOGIC_UNIT, HDB_SITE.SEGMENT_NO, HDB_SITE.RIVER_MILE, HDB_SITE.ELEVATION,
 HDB_SITE.DESCRIPTION, HDB_SITE.NWS_CODE, HDB_SITE.SCS_ID, HDB_SITE.SHEF_CODE, HDB_SITE.USGS_ID, HDB_SITE.DB_SITE_CODE,
 HDB_DATATYPE.DATATYPE_NAME, HDB_DATATYPE.DATATYPE_COMMON_NAME, HDB_DATATYPE.PHYSICAL_QUANTITY_NAME,
 HDB_DATATYPE.AGEN_ID,
 HDB_UNIT.UNIT_COMMON_NAME,
 HDB_SITE_DATATYPE.SITE_DATATYPE_ID
 order by HDB_SITE.SITE_COMMON_NAME, HDB_DATATYPE.DATATYPE_COMMON_NAME
