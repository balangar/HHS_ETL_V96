USE SACWISCUY
GO

DELETE FROM SACWISCUY.DBO.PLACEMENT_LEAVE
WHERE PLACEMENT_LEAVE_ID IN
(SELECT *
FROM OPENQUERY(ADHOC_SACRPT,'
SELECT 
	PLACEMENT_LEAVE_ID
FROM SACWIS.PLACEMENT_LEAVE
WHERE MODIFIED_DATE >= SYSDATE - 7
'))

INSERT INTO SACWISCUY.DBO.PLACEMENT_LEAVE
SELECT 
PLACEMENT_SETTING_ID
, PLACEMENT_LEAVE_ID
, ESTIMATED_RETURN_DATE
, LEAVE_DATE
, LEAVE_TYPE_CODE
, LOCATION_DETAIL_TEXT
, LOCATION_TYPE_CODE
, RETURN_DATE
, PROVIDER_ID
, CREATED_BY
, CREATED_DATE
, MODIFIED_BY
, MODIFIED_DATE
, CREATED_IN_ERROR_FLAG
, PAID_LEAVE_DAYS
, PAID_LEAVE_OVERRIDE_COMMENT
, PLACEMENT_TYPE_CODE
, GROUP_CAT_ID
, APP_VERSION_NBR

FROM OPENQUERY(ADHOC_SACRPT,'
SELECT 
PLACEMENT_SETTING_ID
, PLACEMENT_LEAVE_ID
, ESTIMATED_RETURN_DATE
, LEAVE_DATE
, LEAVE_TYPE_CODE
, LOCATION_DETAIL_TEXT
, LOCATION_TYPE_CODE
, RETURN_DATE
, PROVIDER_ID
, CREATED_BY
, CREATED_DATE
, MODIFIED_BY
, MODIFIED_DATE
, CREATED_IN_ERROR_FLAG
, PAID_LEAVE_DAYS
, PAID_LEAVE_OVERRIDE_COMMENT
, PLACEMENT_TYPE_CODE
, GROUP_CAT_ID
, APP_VERSION_NBR
FROM SACWIS.PLACEMENT_LEAVE
WHERE MODIFIED_DATE >= SYSDATE - 7 
')