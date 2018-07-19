use SacwisCuy
go

truncate table Case_Category
go

insert into Case_Category
select 
  CASE_CATEGORY_ID 
, CASE_ID 
, CASE_CATEGORY_CODE 
, BEGIN_EFF_DATE 
, END_EFF_DATE 
, CREATED_BY 
, CREATED_DATE 
, MODIFIED_BY 
, MODIFIED_DATE 
, AR_PATHWAY_SWITCH 
, APP_VERSION_NBR 

from openquery(adhoc_sacrpt,'
select 
  CASE_CATEGORY_ID 
, CASE_ID 
, CASE_CATEGORY_CODE 
, BEGIN_EFF_DATE 
, END_EFF_DATE 
, CREATED_BY 
, CREATED_DATE 
, MODIFIED_BY 
, MODIFIED_DATE 
, AR_PATHWAY_SWITCH 
, APP_VERSION_NBR 
from sacwis.Case_Category
-- where 
')