use SacwisCuy
go

truncate table Provider_Char_Detail
go

insert into Provider_Char_Detail
select 
PROVIDER_CHAR_DETAIL_ID
, CHARACTERISTIC_CODE
, WILLING_TO_CONSIDER_CODE
, PROVIDER_CHAR_ID
, CREATED_BY
, CREATED_DATE
, MODIFIED_BY
, MODIFIED_DATE
, APP_VERSION_NBR

from openquery(adhoc_sacrpt,'
select 
PROVIDER_CHAR_DETAIL_ID
, CHARACTERISTIC_CODE
, WILLING_TO_CONSIDER_CODE
, PROVIDER_CHAR_ID
, CREATED_BY
, CREATED_DATE
, MODIFIED_BY
, MODIFIED_DATE
, APP_VERSION_NBR
from sacwis.Provider_Char_Detail
-- where 
')