use SacwisCuy
go

truncate table Case_Participant_Reln
go

insert into Case_Participant_Reln
select 
CASE_PARTICIPANT_RELN_ID
, CASE_ID, RELATIONSHIP_CODE
, SOURCE_PERSON_ID
, DEST_PERSON_ID
, CREATED_BY
, CREATED_DATE
, MODIFIED_BY
, MODIFIED_DATE
, APP_VERSION_NBR

from openquery(adhoc_sacrpt,'
select 
CASE_PARTICIPANT_RELN_ID
, CASE_ID, RELATIONSHIP_CODE
, SOURCE_PERSON_ID
, DEST_PERSON_ID
, CREATED_BY
, CREATED_DATE
, MODIFIED_BY
, MODIFIED_DATE
, APP_VERSION_NBR
from sacwis.Case_Participant_Reln
-- where 
')