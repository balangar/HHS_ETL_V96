use SacwisCuy
go

truncate table Provider_Name
go

insert into Provider_Name
select 
PROVIDER_ID
, PROVIDER_NAME_ID
, NAME_TEXT
, EFFECTIVE_DATE
, END_DATE
, CREATED_BY
, CREATED_DATE
, MODIFIED_BY
, MODIFIED_DATE
, APP_VERSION_NBR

from openquery(adhoc_sacrpt,'
select
PROVIDER_ID
, PROVIDER_NAME_ID
, NAME_TEXT
, EFFECTIVE_DATE
, END_DATE
, CREATED_BY
, CREATED_DATE
, MODIFIED_BY
, MODIFIED_DATE
, APP_VERSION_NBR

from sacwis.Provider_Name
-- where 
')