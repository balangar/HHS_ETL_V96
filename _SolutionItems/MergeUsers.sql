MERGE
	DSAS_ODAPS.dbo.Users As Target
	USING DSAS_ODAPS.Staging.Users As [Source]
	ON
		Target.ID = [Source].ID

	WHEN MATCHED And
		[Source].IsValid = 1 And [Source].IsLoaded != 1 And
		Target.SysModifyDate <= [Source].SysInsertDate And
		Target.HashSignature != [Source].HashSignature
	THEN
		UPDATE
			SET
				 Target.[SysModifyDate]	= [Source].SysInsertDate
				,Target.[HashSignature]	= [Source].HashSignature
				
				,Target.[CreatedByID]		= [Source].CreatedByID
				,Target.[CreatedDate]		= [Source].CreatedDate
				,Target.[LastModifiedByID]	= [Source].LastModifiedByID
				,Target.[LastModifiedDate]	= [Source].LastModifiedDate
				,Target.[SystemModstamp]	= [Source].SystemModstamp
				
				,Target.[ID]			= [Source].[ID]	
				,Target.[AccountID]		= [Source].[AccountID]	
				,Target.[ContactID]		= [Source].[ContactID]
				
				,Target.[UserName]	= [Source].[UserName]	
				,Target.[FirstName]	= [Source].[FirstName]	
				,Target.[LastName]	= [Source].[LastName]	
				,Target.[Name]		= [Source].[Name]	
				,Target.[EMail]		= [Source].[EMail]	
				,Target.[Phone]		= [Source].[Phone]
				
				,Target.[ManagerID]		= [Source].[ManagerID]	
				,Target.[SupervisorID]	= [Source].[Supervisor__c]

	WHEN NOT MATCHED By Target And [Source].IsValid = 1
	THEN
		INSERT
		( ID,SysInsertDate,SysModifyDate,HashSignature,
		  CreatedByID,CreatedDate,LastModifiedByID,LastModifiedDate,SystemModstamp,
		  [AccountID],[ContactID],
		  [UserName],[FirstName],[LastName],[Name],[EMail],[Phone],[ManagerID],[SupervisorID]
		)
		VALUES
		(
			[Source].ID, [Source].SysInsertDate, [Source].SysInsertDate, [Source].HashSignature,
			[Source].CreatedById, [Source].CreatedDate, [Source].LastModifiedById, [Source].LastModifiedDate,[Source].SystemModstamp, 
			[Source].[AccountID],[Source].[ContactID],
			[Source].[UserName],[Source].[FirstName],[Source].[LastName],[Source].[Name],[Source].[EMail],[Source].[Phone],
			[Source].[ManagerID],[Source].[Supervisor__c]
		)
;