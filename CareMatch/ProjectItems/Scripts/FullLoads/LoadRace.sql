use SacwisCuy
go

truncate table Race
go

insert into Race
select 
RACE_ID
, PERSON_ID
, RACE_CODE
, CREATED_BY
, CREATED_DATE
, MODIFIED_BY
, MODIFIED_DATE
, APP_VERSION_NBR

from openquery(adhoc_sacrpt,'
select
RACE_ID
, PERSON_ID
, RACE_CODE
, CREATED_BY
, CREATED_DATE
, MODIFIED_BY
, MODIFIED_DATE
, APP_VERSION_NBR

from sacwis.Race
-- where 
')