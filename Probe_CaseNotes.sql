/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  top 1000 [ID]
      ,[SysInsertUser]
      ,[SysInsertDate]
      ,[CaseKey]
      ,[CreatedBy]
      ,[EventDate]
      ,[CustodialParentID]
      ,[AbsentparentID]
      ,[OrderNo]
      ,[Contents]
      ,[FileSpec]
      ,[FilePath]
      ,[FileName]
  FROM [OCSS_SCAS].[dbo].[CaseNotes]
  Where CaseKey = '289640936285508793' And EventDate Between '1990-01-01' and '1996-12-31'
  --Where custodialparentID = '275689333'
  --Where FileSpec like '\\ms-hhs-san\ITS\_Archive\OCSS\CaseNotes\091000\%.txt'
  Order by SysInsertDate 

  --Select count(*) from dbo.CaseNotes
  --Select MAX(ID) From dbo.CaseNotes
  --Select count(Distinct CaseKey) from dbo.CaseNotes
  --Select CaseKey, Count(CaseKey) As Cases from dbo.CaseNotes group by CaseKey having Count(CaseKey) >= 400 Order by Cases desc;

--Truncate Table [OCSS_SCAS].[dbo].[CaseNotes]

