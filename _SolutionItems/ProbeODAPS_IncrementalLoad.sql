Select * FROM [DSAS_ODAPS].[dbo].[Accounts]
Select * from [DSAS_ODAPS].[Staging].Accounts


Select * from [DSAS_ODAPS].[Staging].CaseNotes
Select * FROM [DSAS_ODAPS].[dbo].CaseNotes


Select * from [DSAS_ODAPS].[Staging].Cases
Select * FROM [DSAS_ODAPS].[dbo].Cases

Select * from [DSAS_ODAPS].[Staging].Contacts
Select * FROM [DSAS_ODAPS].[dbo].Contacts

Select * from [DSAS_ODAPS].[Staging].Users
Select * FROM [DSAS_ODAPS].[dbo].Users



Update Staging.CaseNotes
	set 
		LoadDate = '1900-01-01',
		IsLoaded = 0,
		SysInsertDate = '2019-08-09'


Truncate Table dbo.CaseNotes