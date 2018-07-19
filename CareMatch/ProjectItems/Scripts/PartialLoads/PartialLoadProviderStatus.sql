USE SACWISCUY
GO

DELETE FROM SACWISCUY.DBO.PROVIDER_STATUS
WHERE PROVIDER_STATUS_ID IN
(SELECT *
FROM OPENQUERY(ADHOC_SACRPT,'
SELECT 
	PROVIDER_STATUS_ID
FROM SACWIS.PROVIDER_STATUS
WHERE MODIFIED_DATE >= SYSDATE - 7
'))

INSERT INTO SACWISCUY.DBO.PROVIDER_STATUS
SELECT 
PROVIDER_ID
, PROVIDER_STATUS_ID
, STATUS_CODE
, EFFECTIVE_DATE
, REVIEW_DATE
, REASON_CODE
, OTHER_REASON_TEXT
, COMMENT_TEXT
, RESOLVED_FLAG
, CREATED_BY
, CREATED_DATE
, MODIFIED_BY
, MODIFIED_DATE
, RESOLVED_DATE
, APP_VERSION_NBR

FROM OPENQUERY(ADHOC_SACRPT,'
SELECT
PROVIDER_ID
, PROVIDER_STATUS_ID
, STATUS_CODE
, EFFECTIVE_DATE
, REVIEW_DATE
, REASON_CODE
, OTHER_REASON_TEXT
, COMMENT_TEXT
, RESOLVED_FLAG
, CREATED_BY
, CREATED_DATE
, MODIFIED_BY
, MODIFIED_DATE
, RESOLVED_DATE
, APP_VERSION_NBR

FROM SACWIS.PROVIDER_STATUS
WHERE MODIFIED_DATE >= SYSDATE - 7
')