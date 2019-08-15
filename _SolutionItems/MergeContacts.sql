MERGE
	DSAS_ODAPS.dbo.Contacts As Target
	USING DSAS_ODAPS.Staging.Contacts As [Source]
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
				
				,Target.[IsDeleted]	= [Source].IsDeleted
				
				,[Target].[ID]	= [Source].[ID] 		
				                                            
				,[Target].[OwnerId]			= [Source].[OwnerId] 
				,[Target].[AccountId]		= [Source].[AccountId] 
				,[Target].[MasterRecordId]	= [Source].[MasterRecordId] 
				                                            
				,[Target].[Salutation]	=     [Source].[Salutation] 
				,[Target].[FirstName]	=     [Source].[FirstName] 
				,[Target].[LastName]	=     [Source].[LastName] 
				,[Target].[Name]		=     [Source].[Name] 
				                                            
				,[Target].[MailingStreet]		= [Source].[MailingStreet] 
				,[Target].[MailingCity]			= [Source].[MailingCity] 
				,[Target].[MailingStateCode]	= [Source].[MailingStateCode] 
				,[Target].[MailingPostalCode]	= [Source].[MailingPostalCode] 
				,[Target].[MailingAddress]		= [Source].[MailingAddress] 
				                                            
				,[Target].[Phone]		= [Source].[Phone] 
				,[Target].[HomePhone]	= [Source].[HomePhone] 
				,[Target].[Email]		= [Source].[Email] 
				                                            
				,[Target].[Birthdate]		= [Source].[Birthdate] 
				,[Target].[Approx_Age__c]	= CASE ISNUMERIC([Source].APPROX_AGE__C) WHEN 1 THEN CONVERT(DECIMAL(4,1), [Source].APPROX_AGE__C) END
				,[Target].[Gender_Code__c]	= [Source].[Gender_Code__c]
				,[Target].[Gender__c]		= [Source].[Gender__c] 
				                                            
				,[Target].[Hoarding_or_animal_hoarding__c]	= [Source].[Hoarding_or_animal_hoarding__c] 
				                                            
				,[Target].[Income_Source__c]	= [Source].[Income_Source__c] 
				,[Target].[Marital_Status__c]	= [Source].[Marital_Status__c] 
				,[Target].[Medicaid__c]			= [Source].[Medicaid__c] 
				,[Target].[Medicare__c]			= [Source].[Medicare__c] 
				,[Target].[Race__c]				= [Source].[Race__c] 
				                                            
				,[Target].[SSN__c]				=  [Source].[SSN__c] 
				,[Target].[Person_Id__c]		=  [Source].[Person_Id__c] 
				,[Target].[Veteran_Status__c]	=  [Source].[Veteran_Status__c] 
				,[Target].[Bed_Bugs__c]			=  [Source].[Bed_Bugs__c] 


	WHEN NOT MATCHED By Target And [Source].IsValid = 1
	THEN
		INSERT
		( ID,SysInsertDate,SysModifyDate,HashSignature,
		  CreatedByID,CreatedDate,LastModifiedByID,LastModifiedDate,SystemModstamp,
		  IsDeleted,
		  [OwnerId],[AccountId],[MasterRecordId],
		  [Salutation],[FirstName],[LastName],[Name], 
		  [MailingStreet],[MailingCity],[MailingStateCode],[MailingPostalCode],[MailingAddress],
		  [Phone],[HomePhone],[Email],
		  [Birthdate],[Approx_Age__c],[Gender_Code__c],[Gender__c],
		  [Hoarding_or_animal_hoarding__c],
		  [Income_Source__c],[Marital_Status__c],[Medicaid__c],[Medicare__c],[Race__c],
		  [SSN__c],[Person_Id__c],[Veteran_Status__c],[Bed_Bugs__c] 		  
		)
		VALUES
		(
			[Source].ID, [Source].SysInsertDate, [Source].SysInsertDate, [Source].HashSignature,
			[Source].CreatedById, [Source].CreatedDate, [Source].LastModifiedById, [Source].LastModifiedDate,[Source].SystemModstamp, 
			[Source].IsDeleted,	
			[Source].[OwnerId],[Source].[AccountId],[Source].[MasterRecordId],
			[Source].[Salutation],[Source].[FirstName],[Source].[LastName],[Source].[Name],
			[Source].[MailingStreet],[Source].[MailingCity],[Source].[MailingStateCode],[Source].[MailingPostalCode],[Source].[MailingAddress],
			[Source].[Phone],[Source].[HomePhone],[Source].[Email],
			[Source].[Birthdate],
			CASE ISNUMERIC([Source].APPROX_AGE__C) WHEN 1 THEN CONVERT(DECIMAL(4,1), [Source].APPROX_AGE__C) END,
			[Source].[Gender_Code__c],[Source].[Gender__c],
			
			[Source].[Hoarding_or_animal_hoarding__c],
			
			[Source].[Income_Source__c],[Source].[Marital_Status__c],[Source].[Medicaid__c],[Source].[Medicare__c],[Source].[Race__c],

			[Source].[SSN__c],[Source].[Person_Id__c],[Source].[Veteran_Status__c],[Source].[Bed_Bugs__c] 
		)
;