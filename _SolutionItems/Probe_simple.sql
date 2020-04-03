Select Count(*) FROM [DSAS_ODAPS].[Staging].[Accounts] --Where IsValid = 0
Select Count(*) FROM [DSAS_ODAPS].dbo.[Accounts]

Select Count(*) FROM [DSAS_ODAPS].[Staging].[Contacts] --Where IsValid = 0
Select Count(*) FROM [DSAS_ODAPS].dbo.[Contacts]

Select Count(*) FROM [DSAS_ODAPS].[Staging].[Cases] --Where IsValid = 0
Select Count(*) FROM [DSAS_ODAPS].dbo.[Cases]

Select Count(*) FROM [DSAS_ODAPS].[Staging].[CaseNotes] --Where IsValid = 0
Select Count(*) FROM [DSAS_ODAPS].dbo.[CaseNotes]

Select Count(*) FROM [DSAS_ODAPS].[Staging].[Users] --Where IsValid = 0
Select Count(*) FROM [DSAS_ODAPS].dbo.[Users]




Select * FROM [DSAS_ODAPS].[Staging].[Accounts] --Where IsValid = 0
Select * FROM [DSAS_ODAPS].dbo.[Accounts]

Select * FROM [DSAS_ODAPS].[Staging].[Contacts] --Where IsValid = 0
Select * FROM [DSAS_ODAPS].dbo.[Contacts]

Select * FROM [DSAS_ODAPS].[Staging].[Cases] --Where IsValid = 0
Select * FROM [DSAS_ODAPS].dbo.[Cases]

Select * FROM [DSAS_ODAPS].[Staging].[CaseNotes] --Where IsValid = 0
Select * FROM [DSAS_ODAPS].dbo.[CaseNotes]

Select * FROM [DSAS_ODAPS].[Staging].[Users] --Where IsValid = 0
Select * FROM [DSAS_ODAPS].dbo.[Users]

Select max(SysInsertDate), max(SysModifyDate) from dbo.Cases
Select * from dbo.Cases Where SysModifyDate = (Select max(sysmodifydate) from dbo.Cases) order by sysinsertdate

Select max(SysInsertDate), max(SysModifyDate) from dbo.CaseNotes
Select * from dbo.CaseNotes Where SysModifyDate = (Select max(sysmodifydate) from dbo.CaseNotes) order by sysinsertdate


--Truncate Table dbo.Cases