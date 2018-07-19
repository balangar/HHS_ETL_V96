use SacwisCuy
go

truncate table Prvdr_Plcmnt_Criteria_Detail
go

insert into Prvdr_Plcmnt_Criteria_Detail
select 
PRVDR_PLCM_CRIT_DETAIL_ID
, MINIMUM_AGE_YEARS_NBR
, MINIMUM_AGE_MONTH_NBR
, MAXIMUM_AGE_YEARS_NBR
, MAXIMUM_AGE_MONTH_NBR
, GENDER_CODE
, NUMBER_OF_CHILDREN_NBR
, PROVIDER_PLCMNT_CRITERIA_ID
, CREATED_BY
, CREATED_DATE
, MODIFIED_BY
, MODIFIED_DATE
, APP_VERSION_NBR

from openquery(adhoc_sacrpt,'
select
PRVDR_PLCM_CRIT_DETAIL_ID
, MINIMUM_AGE_YEARS_NBR
, MINIMUM_AGE_MONTH_NBR
, MAXIMUM_AGE_YEARS_NBR
, MAXIMUM_AGE_MONTH_NBR
, GENDER_CODE
, NUMBER_OF_CHILDREN_NBR
, PROVIDER_PLCMNT_CRITERIA_ID
, CREATED_BY
, CREATED_DATE
, MODIFIED_BY
, MODIFIED_DATE
, APP_VERSION_NBR

from sacwis.Prvdr_Plcmnt_Criteria_Detail
-- where 
')