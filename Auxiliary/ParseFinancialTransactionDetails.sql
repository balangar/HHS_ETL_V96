--Select count(*) from dbo.FinancialTransActionDetails

--Select Top 5000 * FROM [OCSS_SCAS].[dbo].[FinancialTransActionDetails]


--Select TRY_CAST(SUBSTRING('01  A   O039035000     1.35         000000    0.00', 20, 8) As money)

--Select try_cast(substring(contents, 20,8) as money) from dbo.FinancialTransActionDetails Where ID = 28228


--Select Top 10000
--	TRY_CAST(SUBSTRING(Contents, 20, 8) AS money) As AMnt, *
--From
--	dbo.FinancialTransActionDetails

--Select
--	 try_cast(substring(contents, 20,8) as money) As Amnt, *
--From
--	dbo.FinancialTransActionDetails
--WHERE
-- TransactionType in ('distrib', 'receipt', 'applied', 'disburs') And
--	RecordType IN ('00', '01', '02', '03') And
--	PayType IN ('A', 'B', 'FUT', 'TOT') 
--Order by
--	Amnt

--Select top 10000 * from dbo.FinancialTransActionDetails where amount is null;


--Update dbo.FinancialTransActionDetails
--	SET
--		Amount = TRY_Cast(substring(Contents,20,8) as money)
--	WHERE
--		TransactionType in ('distrib', 'receipt', 'applied', 'disburs') And
--		RecordType IN ('00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22',  
--			'23', '24', '25', '26', '27', '28', '29', '30', '31', 'TO', 'TOT') And
--		PayType IN ('', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'P', 'R', 'BND', 'FUT',  'IRJ', 'IRS', 'LMP',  'ODT', 'PRE', 'URS')

--Select top 10000
--	*
--From
--	dbo.FinancialTransActionDetails
--Where 
--	TransactionType in ('distrib', 'receipt', 'applied', 'disburs') And Amount Is Null and RecordType != 'FRM' --And RecordType IN ('00', '01', '02', '03', 'TO', 'TOT')  And Amount IS NULL

--Select Top 300000 
--	CASE
--		When LTRIM(RTRIM(SUBSTRING(CONTENTS, 9, 10))) = '' Then NULL
--		Else LTRIM(RTRIM(SUBSTRING(CONTENTS, 9, 10)))
--	End As AltPayee, * 
--From 
--	[OCSS_SCAS].[dbo].[FinancialTransActionDetails] 
--Where 
--	TransactionType IN ('distrib', 'receipt', 'applied', 'disburs')
--Order by
--	ID desc

--UPDATE dbo.FinancialTransActionDetails
--	Set
--		AlternatePayeeID =
--			CASE
--				When LTRIM(RTRIM(SUBSTRING(CONTENTS, 9, 10))) = '' Then NULL
--				Else LTRIM(RTRIM(SUBSTRING(CONTENTS, 9, 10)))
--			End
--	Where 
--		TransactionType IN ('distrib', 'receipt', 'applied', 'disburs')






           
