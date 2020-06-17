/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ID]
      ,[SysInsertDate]
      ,[IndividualID]
      ,[Name]
      ,[FirstName]
      ,[LastName]
      ,[FileSpec]
      ,[FilePath]
      ,[FileName]
  FROM [OCSS_SCAS].[dbo].[WIPS]
  Where IndividualID = '006549256'

  Select count(*)   FROM [OCSS_SCAS].[dbo].[WIPS]