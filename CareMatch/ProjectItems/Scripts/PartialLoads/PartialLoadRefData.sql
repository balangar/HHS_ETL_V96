USE SACWISCUY
GO

DELETE FROM SACWISCUY.DBO.REF_DATA
WHERE REF_DATA_ID IN
(SELECT *
FROM OPENQUERY(ADHOC_SACRPT,'
SELECT 
	REF_DATA_ID
FROM SACWIS.REF_DATA
WHERE MODIFIED_DATE >= SYSDATE - 7
'))

INSERT INTO SACWISCUY.DBO.REF_DATA
SELECT 
REF_DATA_ID
, PARENT_REF_DATA_CODE
, DOMAIN_CODE
, REF_DATA_CODE
, SHORT_DESC
, LONG_DESC
, SORT_VALUE
, INACTIVE_FLAG
, CREATED_BY
, CREATED_DATE
, MODIFIED_BY
, MODIFIED_DATE
, REF_DATA_CONFIG_ID
, GROUP_CODE
, APP_VERSION_NBR

FROM OPENQUERY(ADHOC_SACRPT,'
SELECT
REF_DATA_ID
, PARENT_REF_DATA_CODE
, DOMAIN_CODE
, REF_DATA_CODE
, SHORT_DESC
, LONG_DESC
, SORT_VALUE
, INACTIVE_FLAG
, CREATED_BY
, CREATED_DATE
, MODIFIED_BY
, MODIFIED_DATE
, REF_DATA_CONFIG_ID
, GROUP_CODE
, APP_VERSION_NBR

FROM SACWIS.REF_DATA
WHERE MODIFIED_DATE >= SYSDATE - 7
')