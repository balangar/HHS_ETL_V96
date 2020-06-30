--Select * into dbo.OMIS From Staging.OMIS

--Select * from dbo.OMIS  Where casenumber = 'A000110501'

--Select Distinct AbeyanceIndicator From dbo.OMIS

--UPDATE dbo.OMIS
--	SET
--		OrderFilingDate = TRY_CAST(OrderFilingDate As Date),
--		LastModifyDate = TRY_CAST(LastModifyDate As Date),
--		WageAttStartDate = TRY_CAST(WageAttStartDate As Date),
--		WageAttEndDate = TRY_CAST(WageAttEndDate As Date),
--		OrderReviewDate = TRY_CAST(OrderReviewDate As Date),
--		AmountOrderHold = TRY_CAST(AmountOrderHold As money),
--		AmountODTHold = TRY_CAST(AmountODTHold As Money),
--		AmountIRSHold = TRY_CAST(AmountIRSHold As Money),
--		AmountIRSJointHold = TRY_CAST(AmountIRSJointHold As Money),
--		AmountLumpHold = TRY_CAST(AmountLumpHold As Money),
--		LastCalcDate = TRY_CAST(LastCalcDate As Date)

--Select * from dbo.OMIS where LastCalcDate = '1900-01-01'

--Begin Tran
--Update dbo.OMIS
--	Set
--		LastCalcDate = NULL
--	where LastCalcDate = '1900-01-01';

--Select * from dbo.OMIS;

--Commit

--Select * from dbo.OMIS Where Abeyanceindicator not in ('y', 'n')

--Update dbo.OMIS
--	Set AbeyanceIndicator = NULL
--	Where Abeyanceindicator not in ('y', 'n')

--Select * from dbo.OMIS where LTRIM(RTRIM(OutOfStateSONum)) = ''

--Begin Tran
--	UPDATE dbo.OMIS
--		Set
--			OutOfStateSONum = NULL
--		where 
--			LTRIM(RTRIM(OutOfStateSONum)) = '';

--	UPDATE dbo.OMIS
--		Set
--			Comments = NULL
--				where 
--			LTRIM(RTRIM(Comments)) = '';


--Select * from dbo.OMIS;
--Commit