use SacwisCuy
go

truncate table Provider
go

insert into Provider
select 
PROVIDER_ID
 , PROVIDER_CATEGORY_CODE
 , PARTY_ID, CREATED_BY
 , CREATED_DATE
 , MODIFIED_BY
 , MODIFIED_DATE
 , APP_VERSION_NBR

from openquery(adhoc_sacrpt,'
select 
PROVIDER_ID
 , PROVIDER_CATEGORY_CODE
 , PARTY_ID, CREATED_BY
 , CREATED_DATE
 , MODIFIED_BY
 , MODIFIED_DATE
 , APP_VERSION_NBR
from sacwis.Provider
-- where 
')