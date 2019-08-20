--Select * from Staging.Accounts
--Select * from dbo.Accounts

--Select * from Staging.Contacts 
--Select * from dbo.Contacts

Select * from Staging.Users --Where id = '003t000000HV5ujAAD'
Select * from dbo.Users --where id = '003t000000HV5ujAAD'
Select Min(SysModifyDate) As MinMod, Max(SysModifyDate) As MaxMod From dbo.Users

--Select * from dbo.Users Where SysModifyDate > '2019-08-13'
Select * from dbo.Contacts Where SysModifyDate = SysInsertDate And SysModifyDate > '2019-08-15'
Select * from dbo.Contacts Where SysModifyDate > SysInsertDate And SysModifyDate > '2019-08-15'

--Truncate Table Staging.Users
--Truncate Table dbo.Users

--Delete  from dbo.CaseNotes Where ID = 'a08t000000HLnruAAD'

--Update dbo.Cases	
--	Set
--		SysModifyDate = '2019-08-11'
--	Where
--		ID = 'a00t000000AgP4GAAV'

--Update Staging.Contacts
--	Set
--		IsLoaded = 0


