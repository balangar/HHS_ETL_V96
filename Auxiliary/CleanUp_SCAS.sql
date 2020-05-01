Select * FROM [OCSS_SCAS].[Staging].[Fred]

--UPDATE Staging.Fred
--	Set
--		CustodialParentID = LEFT(CaseKey,9),
--		AbsentParentID    = RIGHT(CaseKey,9)

--UPDATE Staging.Fred
--	SET
--		CL_ChildRelation = SC_ChildCounter,
--		AP_ChildRelation = ProsecutorID

--UPDATE Staging.Fred
--	SET
--		SC_ChildCounter = Field12

--Alter table Staging.Fred
--	DROP 
--		COLUMN ProsecutorID,
--		COLUMN Field12

--exec sp_rename 'OCSS_SCAS.Staging.Fred.Field14', 'ProsecutorID', 'COLUMN'

--Select * FROM [OCSS_SCAS].[Staging].[Fred] Where ProsecutorID IS NOT NULL

--exec sp_rename 'OCSS_SCAS.Staging.Fred.AgencyToShortDate', 'AgencyToShortDate_Text', 'COLUMN'
--exec sp_rename 'OCSS_SCAS.Staging.Fred.AgencyFromShortDate', 'AgencyFromShortDate_Text', 'COLUMN'
--exec sp_rename 'OCSS_SCAS.Staging.Fred.GoodCauseEstablishedShortDate', 'GoodCauseEstablishedShortDate_Text', 'COLUMN'
--exec sp_rename 'OCSS_SCAS.Staging.Fred.ApplSignedShortDate', 'ApplSignedShortDate_Text', 'COLUMN'
--exec sp_rename 'OCSS_SCAS.Staging.Fred.DateAddedShortDate', 'DateAddedShortDate_Text', 'COLUMN'
--exec sp_rename 'OCSS_SCAS.Staging.Fred.LastUpdatedShortDate', 'LastUpdatedShortDate_Text', 'COLUMN'

--ALTER TABLE Staging.Fred
--	ADD
--		AgencyToDate				DATE NULL,
--		AgencyFromDate				DATE NULL,
--		GoodCauseEstablishedDate	DATE NULL,
--		ApplSignedDate				DATE NULL,
--		DateAddedDate				DATE NULL,
--		LastUpdatedDate				DATE NULL

--UPDATE Staging.Fred
--	SET
--		AgencyToDate				= TRY_CAST(AgencyToShortDate_Text As Date),
--		AgencyFromDate				= TRY_CAST(AgencyFromShortDate_Text As Date),
--		GoodCauseEstablishedDate	= TRY_CAST(GoodCauseEstablishedShortDate_Text As Date),
--		ApplSignedDate				= TRY_CAST(ApplSignedShortDate_Text As Date),
--		DateAddedDate				= TRY_CAST(DateAddedShortDate_Text As Date),
--		LastUpdatedDate				= TRY_CAST(LastUpdatedShortDate_Text As Date)

--Alter table Staging.Fred
--	DROP 
--		COLUMN AgencyToShortDate_Text,
--		COLUMN AgencyFromShortDate_Text,
--		COLUMN GoodCauseEstablishedShortDate_Text,
--		COLUMN ApplSignedShortDate_Text,
--		COLUMN DateAddedShortDate_Text,
--		COLUMN LastUpdatedShortDate_Text

--Select * FROM [OCSS_SCAS].[Staging].[Fred] Where IsGoodCauseEstablished = 'Y'

--Select * from Staging.Fred Where CaseKey = '285507004241765358'


