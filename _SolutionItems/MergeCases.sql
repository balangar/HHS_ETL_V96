MERGE
	DSAS_ODAPS.dbo.Cases As Target
	USING DSAS_ODAPS.Staging.Cases As [Source]
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
				
				,Target.[Referral_Submitted_Date_Time__c]	= [Source].Referral_Submitted_Date_Time__c
				,Target.[Case_Decision_Date_Time__c]		= [Source].Case_Decision_Date_Time__c
				
				,Target.[OwnerId]		= [Source].OwnerId
				,Target.[RecordTypeID]	= [Source].RecordTypeID
				
				,Target.[Owner_County__c]	= [Source].Owner_County__c
				
				,Target.[Name]				= [Source].[Name]
				,Target.[ContactPersonID]	= [Source].ContactPersonID
				,Target.[CaseSeqNo]			= [Source].CaseSeqNo
				
				,Target.[Approximate_Age__c]	= [Source].Approximate_Age__c
				,Target.[Caretaker_Neglect__c]	= [Source].Caretaker_Neglect__c
				,Target.[Case_Closed_Reason__c]	= [Source].Case_Closed_Reason__c
				
				,Target.[Client_Address__c]				= [Source].Client_Address__c
				,Target.[Client_Name__c]				= [Source].Client_Name__c
				,Target.[Client_s_Age__c]				= [Source].Client_s_Age__c
				,Target.[Client_s_Home_Phone_Number__c]	= [Source].Client_s_Home_Phone_Number__c
				
				,Target.[Date_of_Birth__c]	= [Source].Date_of_Birth__c
				
				,Target.[Exploitation__c]					= [Source].Exploitation__c
				,Target.[Gender_Code__c]					= [Source].Gender_Code__c
				,Target.[Marital_Status_Code__c]			= [Source].Marital_Status_Code__c
				,Target.[Physical_Abuse__c]					= [Source].Physical_Abuse__c
				,Target.[Reporting_Party_Agency_Name__c]	= [Source].Reporting_Party_Agency_Name__c
				,Target.[Reporting_Party_Name__c]			= [Source].Reporting_Party_Name__c
				
				,Target.[Self_Neglect__c]					= [Source].Self_Neglect__c
				,Target.[Sexual_Abuse__c]					= [Source].Sexual_Abuse__c
				,Target.[Hoarding_or_animal_hoarding__c]	= [Source].Hoarding_or_animal_hoarding__c
				,Target.[Emotional_Verbal_Abuse__c]			= [Source].Emotional_Verbal_Abuse__c
				,Target.[Bed_Bugs__c]						= [Source].Bed_Bugs__c
				,Target.[Substance_abuse__c]				= [Source].Substance_abuse__c
				
				,Target.[Diagnosed_Mental_Illness_Info__c]	= [Source].Diagnosed_Mental_Illness_Info__c
				,Target.[Diagnosed_Mental_Illness__c]		= [Source].Diagnosed_Mental_Illness__c
				
				
				,Target.[Supervisor_E_mail__c]	= [Source].Supervisor_E_mail__c
				,Target.[Supervisor_Name__c]	= [Source].Supervisor_Name__c
				,Target.[Supervisor__c]			= [Source].Supervisor__c			


	WHEN NOT MATCHED By Target And [Source].IsValid = 1
	THEN
		INSERT
		( ID,SysInsertDate,SysModifyDate,HashSignature,
		  CreatedByID,CreatedDate,LastModifiedByID,LastModifiedDate,SystemModstamp,
		  IsDeleted,
		  OwnerId,RecordTypeID,Owner_County__c,[Name],
		  ContactPersonID,CaseSeqNo,
		  Approximate_Age__c,
		  Caretaker_Neglect__c,Case_Closed_Reason__c,	  
		  Client_Address__c,Client_Name__c,Client_s_Age__c,Client_s_Home_Phone_Number__c,Date_of_Birth__c,
		  Exploitation__c,Gender_Code__c,Marital_Status_Code__c,Physical_Abuse__c,Reporting_Party_Agency_Name__c,
		  Reporting_Party_Name__c,Self_Neglect__c,Sexual_Abuse__c,Supervisor_E_mail__c,Supervisor_Name__c,Supervisor__c,
		  Hoarding_or_animal_hoarding__c,Emotional_Verbal_Abuse__c,Referral_Submitted_Date_Time__c,Bed_Bugs__c,
		  Substance_abuse__c,Diagnosed_Mental_Illness_Info__c,Diagnosed_Mental_Illness__c,Case_Decision_Date_Time__c
		)
		VALUES
		(
			[Source].ID, [Source].SysInsertDate, [Source].SysInsertDate, [Source].HashSignature,
			[Source].CreatedById, [Source].CreatedDate, [Source].LastModifiedById, [Source].LastModifiedDate,[Source].SystemModstamp, 
			[Source].IsDeleted,	
			[Source].OwnerId,[Source].RecordTypeID,[Source].Owner_County__c,[Source].[Name],
			[Source].ContactPersonID,[Source].CaseSeqNo,
			[Source].Approximate_Age__c,
			[Source].Caretaker_Neglect__c,[Source].Case_Closed_Reason__c,
			[Source].Client_Address__c,[Source].Client_Name__c,[Source].Client_s_Age__c,[Source].Client_s_Home_Phone_Number__c,[Source].Date_of_Birth__c,
			[Source].Exploitation__c,[Source].Gender_Code__c,[Source].Marital_Status_Code__c,[Source].Physical_Abuse__c,[Source].Reporting_Party_Agency_Name__c,
			[Source].Reporting_Party_Name__c,[Source].Self_Neglect__c,[Source].Sexual_Abuse__c,[Source].Supervisor_E_mail__c,[Source].Supervisor_Name__c,[Source].Supervisor__c,
			[Source].Hoarding_or_animal_hoarding__c,[Source].Emotional_Verbal_Abuse__c,[Source].Referral_Submitted_Date_Time__c,[Source].Bed_Bugs__c,
			[Source].Substance_abuse__c,[Source].Diagnosed_Mental_Illness_Info__c,[Source].Diagnosed_Mental_Illness__c,[Source].Case_Decision_Date_Time__c
		)
;