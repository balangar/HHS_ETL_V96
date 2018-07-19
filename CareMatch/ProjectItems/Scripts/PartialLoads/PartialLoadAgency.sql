USE SACWISCUY
GO

DELETE FROM SACWISCUY.DBO.AGENCY
WHERE AGENCY_ID IN
(SELECT *
FROM OPENQUERY(ADHOC_SACRPT,'
SELECT 
	AGENCY_ID
FROM SACWIS.AGENCY
WHERE MODIFIED_DATE >= SYSDATE - 7
'))

INSERT INTO SACWISCUY.DBO.AGENCY
SELECT 
AGENCY_ID
, PARTY_ID
, AGENCY_CODE
, AGENCY_LOGO_CODE
, AGENCY_NAME
, AGENCY_REFERENCE_ID
, COA_FLAG
, COMMENTS_TEXT
, INACTIVE_FLAG
, MAIN_OFFICE_FLAG
, CWLA_FLAG
, IVE_FLAG
, NASW_FLAG
, OFFICE_URL
, PUBLIC_AGENCY_FLAG
, BULK_MED_FLAG
, CREATED_BY
, CREATED_DATE
, MODIFIED_BY
, MODIFIED_DATE
, PLACEMENT_PAY_FLAG
, PAYMENT_CODE
, ACCOUNT_NUMBER
, EIN_NUMBER
, ADDRESS_CODE
, OAKS_VENDOR_ID
, MEDICAID_LIVE_FLAG
, DEFAULT_COURT_DETAIL_ID
, RAPBACK_AGENCY_ID
, APP_VERSION_NBR

FROM OPENQUERY(ADHOC_SACRPT,'
SELECT 
AGENCY_ID
, PARTY_ID
, AGENCY_CODE
, AGENCY_LOGO_CODE
, AGENCY_NAME
, AGENCY_REFERENCE_ID
, COA_FLAG
, COMMENTS_TEXT
, INACTIVE_FLAG
, MAIN_OFFICE_FLAG
, CWLA_FLAG
, IVE_FLAG
, NASW_FLAG
, OFFICE_URL
, PUBLIC_AGENCY_FLAG
, BULK_MED_FLAG
, CREATED_BY
, CREATED_DATE
, MODIFIED_BY
, MODIFIED_DATE
, PLACEMENT_PAY_FLAG
, PAYMENT_CODE
, ACCOUNT_NUMBER
, EIN_NUMBER
, ADDRESS_CODE
, OAKS_VENDOR_ID
, MEDICAID_LIVE_FLAG
, DEFAULT_COURT_DETAIL_ID
, RAPBACK_AGENCY_ID
, APP_VERSION_NBR
FROM SACWIS.AGENCY
WHERE MODIFIED_DATE >= SYSDATE - 7
')