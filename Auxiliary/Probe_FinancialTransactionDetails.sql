--SELECT TOP (1000)
--       chrisOFIN.*
--       , substring(col5, 1, 2)
--       , case when col4 = 'APPLIED' and substring(col5, 1, 2)  = '00' then cast(substring(col5, 4, 24) as money) else null end
--       , case when col4 = 'APPLIED' and substring(col5, 1, 2) <> '00' then substring(col5, 4, 1) else null end
--       , case when col4 = 'APPLIED' and substring(col5, 1, 2) <> '00' then substring(col5, 6, 1) else null end
--       , substring(col5, 1, 20)

--FROM [OCSS_SCAS].[Staging].[chrisOFIN]

--Select * from dbo.FinancialTransActionDetails Where TransactionType NOT IN ('receipt', 'applied', 'disburs', 'distrib') = 'Receipt' and substring(contents,1,2) = '00'
--CASE When (TransactionType In ('receipt', 'applied', 'disburs', 'distrib')) Then substring(contents,1,2) ELSE NULL END
--UPDATE dbo.FinancialTransActionDetails
--	Set
--		TransactionSubType = NULL
--	Where TransactionType NOT IN ('receipt', 'applied', 'disburs', 'distrib')

--A000961404204900, A001306201204500, D005050003903500, D008736103903500	--TransactionType = 'RECEIPT' and TransactionSubType = '00' And TRY_CAST(substring(contents,4,24) as money) IS NULL

--Select --Top 10 
--	*, TotalApplied = CAST(substring(contents,4,24) as money )
--	--TotalApplied = Case When TransactionType = 'Applied' And substring(contents, 1, 2) = '00' Then CAST(substring(contents,4,24) as money) else null END 

--From
--	dbo.FinancialTransActionDetails f
--Where
--	TransactionType = 'APPLIED' and TransactionSubType = '00' --And TRY_CAST(substring(contents,4,24) as money) IS NULL

Select top 1 * from dbo.FinancialTransActionDetails Where OrderNumber IN ('A000961404204900') And TransactionType = 'RECEIPT' and TransactionSubType = '00' And TRY_CAST(substring(contents,4,24) as money) IS NULL
UNION
Select top 1 * From dbo.FinancialTransActionDetails  Where OrderNumber In ('A000040003606100') And TransactionType = 'RECEIPT' and TransactionSubType = '00' -- Where OrderNumber In ('TransactionType = 'RECEIPT' and TransactionSubType = '00' And TRY_CAST(substring(contents,4,24) as money) IS NULL'

Select count(*) from dbo.FinancialTransActionDetails Where TransactionType = 'receipt' and TransactionSubType = '00' and TRY_Cast(substring(Contents,4,24) as money) IS NULL

Select count(*) From dbo.FinancialTransActionDetails Where TransactionType = 'receipt' and TransactionSubType = '00'


Select top 100  * from dbo.FinancialTransActionDetails Where TransactionType = 'applied' and TransactionSubType = '00' and TRY_Cast(substring(Contents,4,24) as money) IS NULL

Select top 100  * from dbo.FinancialTransActionDetails Where TransactionType = 'disburs' and TransactionSubType = '00' and TRY_Cast(substring(Contents,4,24) as money) IS NULL




Select top 100  * from dbo.FinancialTransActionDetails Where TransactionType = 'receipt' and TransactionSubType = '00' --and TRY_Cast(substring(Contents,4,24) as money) IS NULL


Select count(*) from dbo.FinancialTransActionDetails Where TransactionType = 'receipt' and TransactionSubType = '00' and TRY_Cast(substring(Contents,4,24) as money) IS NULL
UNION ALL
Select count(*) From dbo.FinancialTransActionDetails Where TransactionType = 'receipt' and TransactionSubType = '00'


Select count(*) from dbo.FinancialTransActionDetails Where TransactionType = 'applied' and TransactionSubType = '00' and TRY_Cast(substring(Contents,4,24) as money) IS NULL
UNION ALL
Select count(*) From dbo.FinancialTransActionDetails Where TransactionType = 'applied' and TransactionSubType = '00'

Select count(*) from dbo.FinancialTransActionDetails Where TransactionType = 'disburs' and TransactionSubType = '00' and TRY_Cast(substring(Contents,4,24) as money) IS NULL
UNION ALL
Select count(*) From dbo.FinancialTransActionDetails Where TransactionType = 'disburs' and TransactionSubType = '00'

Select Top 5000
	SUBSTRING(Contents, 5, 3), SUBSTRING(Contents, 9, 10), TRY_CAST(SUBSTRING(Contents, 20, 8) AS money) As Amount, *
From dbo.FinancialTransActionDetails
Where
	TransactionType in ('receipt', 'applied', 'disburs') And
	TransactionSubType IN ('01', '02', '03', 'FUT')
Order by
	Amount asc

--Select distinct transactiontype from dbo.FinancialTransActionDetails