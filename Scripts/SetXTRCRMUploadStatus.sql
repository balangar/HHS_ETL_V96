Select * FROM [HHS_Staging].[XTR].[CRM] where uploadtype = 'Insert'



--Update x
--	Set
--		UploadType = 'Update'
--	From
--		HHS_Staging.XTR.CRM x
--		JOIN
--		HHS_Staging.dbo.CRM c
--		ON x.HHSID = c.HHSID

--Update x
--	Set
--		UploadType = 'Update'
--	From
--		HHS_Staging.XTR.CRM x
--		JOIN
--		HHS_MasterData.Infor.CRM c
--		ON x.HHSID = c.HHSID

--Update x
--	Set
--		UploadType = 'Update'
--	From
--		HHS_Staging.XTR.CRM x
--		JOIN
--		HHS_Staging.CRM.Persons c
--		ON x.HHSID = c.HHSID

Update x
	Set
		UploadType = 'Update'
	From
		HHS_Staging.XTR.CRM x
		JOIN
		HHS_Staging.CRM.Persons c
		ON 
			x.LastName = c.LastName And
			x.FirstName = c.FirstName
	Where
		x.UploadType = 'NEW'


Update HHS_Staging.XTR.CRM
	Set
		UploadType ='Insert'
	Where
		Uploadtype = 'New'
