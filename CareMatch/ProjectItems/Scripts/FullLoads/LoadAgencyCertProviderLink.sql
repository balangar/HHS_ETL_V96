use SacwisCuy
go

truncate table Agency_Cert_Provider_Link
go

insert into Agency_Cert_Provider_Link
select 
AGENCY_CERTIFICATION_ID
, PROVIDER_ID
, AGENCY_CERT_PRVDR_LNK_ID
, CONVERTED_DATA
, TRANSFER_AGENCY_CERT_ID
, TRANSFER_AGENCY_CERT_TYPE_CODE
, APP_VERSION_NBR

from openquery(adhoc_sacrpt,'
select 
AGENCY_CERTIFICATION_ID
, PROVIDER_ID
, AGENCY_CERT_PRVDR_LNK_ID
, CONVERTED_DATA
, TRANSFER_AGENCY_CERT_ID
, TRANSFER_AGENCY_CERT_TYPE_CODE
, APP_VERSION_NBR
from sacwis.agency_cert_provider_link
-- where 
')