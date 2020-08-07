FOO!	-- Keep me from executing the whole thing in case I accidentally hit F5 or equivalent

--Drop Table dbo.OPAY

--Select * into dbo.OPAY From Staging.OPAY

--Select * from Staging.OPAY

Select  * from dbo.OPAY 


--Alter Table dbo.OPAY DROP Column Filler01;

--Update dbo.OPAY
--	SET
--		EffectiveDate = TRY_CAST(EffectiveDate AS date),
--		OrginalEffectiveDate = TRY_CAST(OrginalEffectiveDate AS date),
--		EndingDate = TRY_CAST(EndingDate AS date),
--		HoldDate = TRY_CAST(HoldDate AS date)

--Update dbo.OPAY
--	SET
--		AmountDue = TRY_CAST(AmountDue AS money),
--		TotalDue = TRY_CAST(TotalDue AS money),
--		BalanceDue = TRY_CAST(BalanceDue AS money),
--		MonthToDatePayments = TRY_CAST(MonthToDatePayments AS money),
--		YearToDatePayments = TRY_CAST(YearToDatePayments AS money),
--		TTDPayments = TRY_CAST(TTDPayments AS money),
--		AccumulatedPayments = TRY_CAST(AccumulatedPayments AS money),
--		CurrentArrearage = TRY_CAST(CurrentArrearage AS money),
--		PTDObligation = TRY_CAST(PTDObligation AS money),
--		HoldAmount = TRY_CAST(HoldAmount AS money),
--		ApplHoldAmount = TRY_CAST(ApplHoldAmount AS money)


--ALTER TABLE dbo.OPAY	ALTER COLUMN	ArchiveType				char(4)		NOT NULL;
--ALTER TABLE dbo.OPAY	ALTER COLUMN	OrderNumber				char(16)	NOT NULL;
--ALTER TABLE dbo.OPAY	ALTER COLUMN	PayeeType				char(1)		NOT NULL;
--ALTER TABLE dbo.OPAY	ALTER COLUMN	AlterPayeeID			char(10)	NOT NULL;

--ALTER TABLE dbo.OPAY	ALTER COLUMN	EffectiveDate			date		NOT NULL;

--ALTER TABLE dbo.OPAY	ALTER COLUMN	AmountDue				money		NOT NULL;
--ALTER TABLE dbo.OPAY	ALTER COLUMN	TotalDue				money		NOT NULL;
--ALTER TABLE dbo.OPAY	ALTER COLUMN	BalanceDue				money		NOT NULL;
--ALTER TABLE dbo.OPAY	ALTER COLUMN	MonthToDatePayments		money		NOT NULL;
--ALTER TABLE dbo.OPAY	ALTER COLUMN	YearToDatePayments		money		NOT NULL;
--ALTER TABLE dbo.OPAY	ALTER COLUMN	TTDPayments				money		NOT NULL;
--ALTER TABLE dbo.OPAY	ALTER COLUMN	AccumulatedPayments		money		NOT NULL;
--ALTER TABLE dbo.OPAY	ALTER COLUMN	CurrentArrearage		money		NOT NULL;
--ALTER TABLE dbo.OPAY	ALTER COLUMN	PTDObligation			money		NOT NULL;
--ALTER TABLE dbo.OPAY	ALTER COLUMN	HoldAmount				money		NOT NULL;
--ALTER TABLE dbo.OPAY	ALTER COLUMN	ApplHoldAmount			money		NOT NULL;


--ALTER TABLE dbo.OPAY	ALTER COLUMN	OrginalEffectiveDate	date		NULL;
--ALTER TABLE dbo.OPAY	ALTER COLUMN	EndingDate				date		NULL;

--ALTER TABLE dbo.OPAY	ALTER COLUMN	HoldReasonCode			char(3)		NULL;
--ALTER TABLE dbo.OPAY	ALTER COLUMN	HoldDate				date		NULL;
--ALTER TABLE dbo.OPAY	ALTER COLUMN	TakeAssessIndicator		char(1)		NULL;
--ALTER TABLE dbo.OPAY	ALTER COLUMN	HoldReasonCode			char(3)		NULL;
--ALTER TABLE dbo.OPAY	ALTER COLUMN	ArrearsVerifiedFlag		char(1)		NULL;



--CREATE NONCLUSTERED INDEX FK_OrderNumber 
--ON dbo.OPAY(OrderNumber);

--CREATE NONCLUSTERED INDEX OrderInfo_Incl
--ON dbo.OPAY(OrderNumber, PayeeType, EffectiveDate)
--INCLUDE (AlterPayeeID, TakeAssessIndicator, ArrearsVerifiedFlag);




