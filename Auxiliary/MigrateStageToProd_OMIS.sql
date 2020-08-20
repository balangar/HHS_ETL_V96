exec sp_rename 'dbo.OMIS.CaseNumber ', 'OrderNumber', 'COLUMN';
GO


UPDATE  dbo.OMIS
	SET
		OrderFilingDate = TRY_CAST(OrderFilingDate AS DATE),
		LastModifyDate  = TRY_CAST(LastModifyDate AS DATE),
		WageAttStartDate = TRY_CAST(WageAttStartDate AS DATE),
		WageAttEndDate = TRY_CAST(WageAttEndDate AS DATE),
		OrderReviewDate = TRY_CAST(OrderReviewDate AS DATE),
		LastCalcDate = TRY_CAST(LastCalcDate AS DATE);

UPDATE dbo.OMIS
	SET
		AmountOrderHold = TRY_CAST(AmountOrderHold AS MONEY),
		AmountODTHold = TRY_CAST(AmountODTHold AS MONEY),
		AmountIRSHold = TRY_CAST(AmountIRSHold AS MONEY),
		AmountIRSJointHold = TRY_CAST(AmountIRSJointHold AS money),
		AmountLumpHold = TRY_CAST(AmountLumpHold AS money);

ALTER TABLE dbo.OMIS	ALTER COLUMN	OrderNumber char(16) NOT NULL;
ALTER TABLE dbo.OMIS	ALTER COLUMN	GroupNumber int NOT NULL;

ALTER TABLE dbo.OMIS	ALTER COLUMN	OrderFilingDate date;
ALTER TABLE dbo.OMIS	ALTER COLUMN	LastModifyDate date;
ALTER TABLE dbo.OMIS	ALTER COLUMN	WageAttStartDate date;
ALTER TABLE dbo.OMIS	ALTER COLUMN	WageAttEndDate date;
ALTER TABLE dbo.OMIS	ALTER COLUMN	OrderReviewDate date;
ALTER TABLE dbo.OMIS	ALTER COLUMN	LastCalcDate date;

ALTER TABLE dbo.OMIS	ALTER COLUMN	AmountOrderHold money;		
ALTER TABLE dbo.OMIS	ALTER COLUMN	AmountODTHold money;		
ALTER TABLE dbo.OMIS	ALTER COLUMN	AmountIRSHold money;		
ALTER TABLE dbo.OMIS	ALTER COLUMN	AmountIRSJointHold money;		
ALTER TABLE dbo.OMIS	ALTER COLUMN	AmountLumpHold money;



ALTER TABLE dbo.OMIS 
	ADD CONSTRAINT PK_OrderNumber Primary Key (OrderNumber, GroupNumber);
	