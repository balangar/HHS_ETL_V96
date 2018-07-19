USE SACWISCUY
GO

DELETE FROM SACWISCUY.DBO.CASE_PARTICIPANT
WHERE CASE_PARTICIPANT_ID IN
(SELECT *
FROM OPENQUERY(ADHOC_SACRPT,'
SELECT 
	CASE_PARTICIPANT_ID
FROM SACWIS.CASE_PARTICIPANT
WHERE MODIFIED_DATE >= SYSDATE - 7
'))

INSERT INTO SACWISCUY.DBO.CASE_PARTICIPANT
SELECT 
CASE_PARTICIPANT_ID
, CASE_ID
, PERSON_ID
, REFERENCE_PERSON_FLAG
, CREATED_BY
, CREATED_DATE
, MODIFIED_BY
, MODIFIED_DATE
, CURRENT_STATUS_CODE
, APP_VERSION_NBR

FROM OPENQUERY(ADHOC_SACRPT,'
SELECT 
CASE_PARTICIPANT_ID
, CASE_ID
, PERSON_ID
, REFERENCE_PERSON_FLAG
, CREATED_BY
, CREATED_DATE
, MODIFIED_BY
, MODIFIED_DATE
, CURRENT_STATUS_CODE
, APP_VERSION_NBR
FROM SACWIS.CASE_PARTICIPANT
WHERE MODIFIED_DATE >= SYSDATE - 7
')