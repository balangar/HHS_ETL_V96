use SacwisCuy
go

truncate table Provider_Characteristics
go

insert into Provider_Characteristics
select 
PROVIDER_CHAR_ID
, PROVIDER_TYPE_CODE
, EFFECTIVE_DATE
, END_DATE
, STATUS_CODE
, PROVIDER_ID
, CREATED_BY
, CREATED_DATE
, MODIFIED_BY
, MODIFIED_DATE
, APP_VERSION_NBR

from openquery(adhoc_sacrpt,'
select
PROVIDER_CHAR_ID
, PROVIDER_TYPE_CODE
, EFFECTIVE_DATE
, END_DATE
, STATUS_CODE
, PROVIDER_ID
, CREATED_BY
, CREATED_DATE
, MODIFIED_BY
, MODIFIED_DATE
, APP_VERSION_NBR

from sacwis.Provider_Characteristics
-- where 
')