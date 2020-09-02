
FOO!	-- Keep me from executing in case I accidentally hit F5 or equivalent

--Select * Into dbo.ORDR From Staging.ORDR

Select  * from dbo.ORDR 


exec sp_rename 'dbo.ORDR.SSN', 'CaseNumber', 'COLUMN'
exec sp_rename 'dbo.ORDR.SupportOrder', 'OrderNumber', 'COLUMN'
exec sp_rename 'dbo.ORDR.PurgedOFINSFlag', 'PurgedOFINS_Flag', 'COLUMN'

Alter Table dbo.ORDR DROP Column Filler02;

UPDATE dbo.ORDR
	SET
		HoldDate = TRY_CAST(HOLDDATE As Date),
		DateAdded = TRY_CAST(DateAdded AS date),
		DateLastUpdated = TRY_CAST(DateLastUpdated AS date),
		DistributionDate = TRY_CAST(DistributionDate As Date),
		LastDisbursementDate = TRY_CAST(LastDisbursementDate AS DATE),
		OrderEffectiveDate = TRY_CAST(OrderEffectiveDate AS date),
		LastPaymentReceivedDate = TRY_CAST(LastPaymentReceivedDate AS date)

Update dbo.ORDR
	Set
		PrepaymentAmount = TRY_CAST(PrepaymentAmount AS money),
		FutureAmount = TRY_CAST(FutureAmount AS money),
		CashGuaranteeBond = TRY_CAST(CashGuaranteeBond AS money),
		TotalPaidLastModify = TRY_CAST(TotalPaidLastModify AS money),
		TotalPaidOnOrder = TRY_CAST(TotalPaidOnOrder AS money),
		PreviousMonthObligation = TRY_CAST(PreviousMonthObligation AS money),
		PreviousMonthPayment = TRY_CAST(PreviousMonthPayment AS money),
		LastDisbursementAmount = TRY_CAST(LastDisbursementAmount AS money),
		MonthToDateAssessmentPaidAmount = TRY_CAST(MonthToDateAssessmentPaidAmount AS money),
		TotalAssessmntPaidAmount = TRY_CAST(TotalAssessmntPaidAmount AS money),
		TotalAssessmentDebitAmount = TRY_CAST(TotalAssessmentDebitAmount AS money),
		TotalPaidLastCalcAmount = TRY_CAST(TotalPaidLastCalcAmount AS money)

Update dbo.ORDR
	SET
		HoldReason = LTRIM(RTRIM(HoldReason)),
		PurgedOFINS_Flag = LTRIM(RTRIM(PurgedOFINS_Flag)),
		MedOrdInd = LTRIM(RTRIM(MedOrdInd)),
		SocServInd =LTRIM(RTRIM(SocServInd))

Update dbo.ORDR
	Set
		HoldReason = Case When HoldReason = '' Then NULL Else HoldReason End,
		PurgedOFINS_Flag = Case When PurgedOFINS_Flag = '' Then NULL Else PurgedOFINS_Flag End,
		MedOrdInd = Case When MedOrdInd = '' Then NULL Else MedOrdInd End,
		SocServInd = Case When SocServInd = '' Then NULL Else SocServInd End


ALTER TABLE dbo.ORDR	ALTER COLUMN	ArchiveType						char(4)		NOT NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	CaseNumber						char(10)	NOT NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	OrderNumber						char(16)	NOT NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	OrderStatus						char(1)		NOT NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	PaymentResource					char(1)		NOT NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	OutOfStateWELF					char(1)		NOT NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	URESAIndicator					char(1)		NOT NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	FIPSCode						char(6)		NOT NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	ChildCounter					int			NOT NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	DateAdded						date		NOT NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	PrepaymentFlag					char(1)		NOT NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	PrepaymentAmount				money		NOT NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	FutureAmount					money		NOT NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	CashGuaranteeBond				money		NOT NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	TotalPaidLastModify				money		NOT NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	TotalPaidOnOrder				money		NOT NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	PreviousMonthObligation			money		NOT NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	PreviousMonthPayment			money		NOT NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	LastDisbursementAmount			money		NOT NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	MonthToDateAssessmentPaidAmount	money		NOT NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	TotalAssessmntPaidAmount		money		NOT NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	TotalAssessmentDebitAmount		money		NOT NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	TotalAssessmentDebitAmount		money		NOT NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	FrequencyCode					char(1)		NOT NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	TotalPaidLastCalcAmount			money		NOT NULL;


ALTER TABLE dbo.ORDR	ALTER COLUMN	HoldReason				char(3)	NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	HoldDate				date	NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	PurgedOFINS_Flag		char(1)	NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	MedOrdInd				char(1)	NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	DistributionDate		date	NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	LastDisbursementDate	date	NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	OrderEffectiveDate		date	NULL;
ALTER TABLE dbo.ORDR	ALTER COLUMN	LastPaymentReceivedDate	date	NULL;

ALTER TABLE dbo.ORDR 
	ADD CONSTRAINT PK_CaseOrderNumber Primary Key (CaseNumber, OrderNumber);

CREATE NONCLUSTERED INDEX CaseOrderState_Incl
ON dbo.ORDR (HoldDate, HoldReason)
INCLUDE (OrderStatus, PaymentResource, PurgedOFINS_Flag, PrepaymentFlag, FrequencyCode);

CREATE NONCLUSTERED INDEX CaseOrder_ID
ON dbo.ORDR(ID);


















		

