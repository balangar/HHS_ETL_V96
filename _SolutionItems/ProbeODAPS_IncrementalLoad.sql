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

-- Probe counts
/*
Select * From (
	select count(*) As CountAccounts, 'Staging' As [Schema],'Accounts' As TableName from Staging.Accounts 
	UNION
	select count(*) As CountCaseNotes, 'Staging','CaseNotes' from staging.CaseNotes
	UNION
	Select count(*) As CountCases, 'Staging','Cases' from Staging.Cases
	UNION
	Select count(*) As CountCountacts, 'Staging','Contacts' From Staging.Contacts
	UNION
	select count(*) As CountUsers, 'Staging','Users' From Staging.Users
	UNION
	select count(*) As CountAccounts, 'dbo','Accounts' As TableName from dbo.Accounts 
	UNION
	select count(*) As CountCaseNotes, 'dbo','CaseNotes' from dbo.CaseNotes
	UNION
	Select count(*) As CountCases, 'dbo','Cases' from dbo.Cases
	UNION
	Select count(*) As CountCountacts, 'dbo','Contacts' From dbo.Contacts
	UNION
	select count(*) As CountUsers, 'dbo','Users' From dbo.Users
) t
Order by Tablename, [Schema] desc
*/