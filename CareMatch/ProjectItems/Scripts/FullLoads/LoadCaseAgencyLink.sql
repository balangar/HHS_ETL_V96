use SacwisCuy
go

truncate table Case_Agency_Link
go

insert into Case_Agency_Link
select 
CASE_AGENCY_LINK_ID
, CASE_ID
, LOCAL_AGENCY_ID
, BEGIN_EFF_DATE
, END_EFF_DATE
, CREATED_BY
, CREATED_DATE
, MODIFIED_BY
, MODIFIED_DATE
, APP_VERSION_NBR

from openquery(adhoc_sacrpt,'
select 
CASE_AGENCY_LINK_ID
, CASE_ID
, LOCAL_AGENCY_ID
, BEGIN_EFF_DATE
, END_EFF_DATE
, CREATED_BY
, CREATED_DATE
, MODIFIED_BY
, MODIFIED_DATE
, APP_VERSION_NBR
from sacwis.Case_Agency_Link
-- where 
')