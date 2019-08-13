MERGE
	DSAS_ODAPS.dbo.CaseNotes As Target
	USING DSAS_ODAPS.Staging.CaseNotes As [Source]
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

				,Target.[CreatedDate]	 	= [Source].CreatedDate
				,Target.[CreatedById]		= [Source].CreatedById
				,Target.[LastModifiedDate]	= [Source].LastModifiedDate
				,Target.[LastModifiedById]	= [Source].LastModifiedById
				,Target.[SystemModstamp]	= [Source].SystemModstamp

				,Target.[IsDeleted]	= [Source].IsDeleted

				,Target.[RecordTypeId]			= [Source].RecordTypeId
				,Target.[Name]					= [Source].[Name]
				,Target.[LastActivityDate]		= [Source].LastActivityDate
				,Target.[LastViewedDate]		= [Source].LastViewedDate
				,Target.[LastReferencedDate]	= [Source].LastReferencedDate

				,Target.[APS_Case_Number__c]			= [Source].APS_Case_Number__c
				,Target.[APSClientName__c]				= [Source].APSClientName__c
				,Target.[Case_Note_Create_Date_Only__c]	= [Source].Case_Note_Create_Date_Only__c
				,Target.[Case_Note_Interview_Date__c]	= [Source].Case_Note_Interview_Date__c
				,Target.[Characters_in_Note_Text__c]	=  CONVERT(INT,ISNULL(SUBSTRING([Source].Characters_in_Note_Text__c, 1, CHARINDEX('.', [Source].Characters_in_Note_Text__c) - 1), '0'))

				,Target.[Client_Interview_Outside_Perp_Presence__c]	= [Source].Client_Interview_Outside_Perp_Presence__c
				,Target.[Client_Interview__c]						= [Source].Client_Interview__c
				,Target.[Client_Name__c]							= [Source].Client_Name__c

				,Target.[Contact_is_Timely__c]				= [Source].Contact_is_Timely__c
				,Target.[Copy_of_first_255_char_in_note__c]	= [Source].Copy_of_first_255_char_in_note__c
				,Target.[Days_Between_Contact_and_Today__c]	= CONVERT(INT,ISNULL(SUBSTRING([Source].Days_Between_Contact_And_Today__C, 1, CHARINDEX('.', [Source].Days_Between_Contact_And_Today__C) - 1), '0'))
				,Target.[Days_Since_Note_Created__c]		= CONVERT(INT,ISNULL(SUBSTRING([Source].Days_Since_Note_Created__c, 1, CHARINDEX('.', [Source].Days_Since_Note_Created__c) - 1), '0'))
				,Target.[Days_since_last_assessment__c]		= CONVERT(INT,ISNULL(SUBSTRING([Source].Days_since_last_assessment__c, 1, CHARINDEX('.', [Source].Days_since_last_assessment__c) - 1), '0'))

				,Target.[Explain_Why_Perp_Attended_Interview__c]	= [Source].Explain_Why_Perp_Attended_Interview__c
				,Target.[Interview_Conducted_With__c]				= [Source].Interview_Conducted_With__c
				,Target.[Non_Participating_Contact__c]				= [Source].Non_Participating_Contact__c

				,Target.[Note_Created_Contact_Date__c]	= [Source].Note_Created_Contact_Date__c
				,Target.[Note_Type__c]					= [Source].Note_Type__c
				,Target.[Note__c]						= [Source].Note__c
				,Target.[TemporaryAPSCase__c]			= [Source].TemporaryAPSCase__c
				,Target.[Case_Note_Created_in_Error__c]	= [Source].Case_Note_Created_in_Error__c
				,Target.[Case_Note__c]					= [Source].Case_Note__c

				,Target.[Status__c]						= [Source].[Status__c]
				,Target.[Supervisor_Email__c]			= [Source].Supervisor_Email__c
				,Target.[Created_in_Error_Formatted__c]	= [Source].Created_in_Error_Formatted__c
				,Target.[Parent__c]						= [Source].Parent__c

	WHEN NOT MATCHED By Target And [Source].IsValid = 1
	THEN
		INSERT
		(
			ID,SysInsertDate,SysModifyDate,HashSignature,CreatedByID,CreatedDate,LastModifiedByID,LastModifiedDate,SystemModstamp,
			IsDeleted,LastActivityDate,LastViewedDate,LastReferencedDate

			,RecordTypeId,[Name]
			
			,APS_Case_Number__c,APSClientName__c,Case_Note_Create_Date_Only__c,Case_Note_Interview_Date__c,Characters_in_Note_Text__c

			,Client_Interview_Outside_Perp_Presence__c,Client_Interview__c,Client_Name__c
			
			,Contact_is_Timely__c,Copy_of_first_255_char_in_note__c,Days_Between_Contact_and_Today__c,Days_Since_Note_Created__c,Days_since_last_assessment__c

			,Explain_Why_Perp_Attended_Interview__c,Interview_Conducted_With__c,Non_Participating_Contact__c

			,Note_Created_Contact_Date__c,Note_Type__c,Note__c,TemporaryAPSCase__c,Case_Note_Created_in_Error__c,Case_Note__c

			,[Status__c],Supervisor_Email__c,Created_in_Error_Formatted__c
			
			,Parent__c
		)
		VALUES
		(
			[Source].ID, [Source].SysInsertDate, [Source].SysInsertDate, [Source].HashSignature
			,[Source].CreatedById, [Source].CreatedDate, [Source].LastModifiedById, [Source].LastModifiedDate
			,[Source].SystemModstamp, [Source].IsDeleted,[Source].LastActivityDate,[Source].LastViewedDate,[Source].LastReferencedDate

			,[Source].RecordTypeId,[Source].[Name]

			,[Source].APS_Case_Number__c,[Source].APSClientName__c,[Source].Case_Note_Create_Date_Only__c,[Source].Case_Note_Interview_Date__c
			,CONVERT(INT,ISNULL(SUBSTRING([Source].Characters_in_Note_Text__c, 1, CHARINDEX('.', [Source].Characters_in_Note_Text__c) - 1), '0'))

			,[Source].Client_Interview_Outside_Perp_Presence__c,[Source].Client_Interview__c,[Source].Client_Name__c

			,[Source].Contact_is_Timely__c,[Source].Copy_of_first_255_char_in_note__c
			,CONVERT(INT,ISNULL(SUBSTRING([Source].Days_Between_Contact_And_Today__C, 1, CHARINDEX('.', [Source].Days_Between_Contact_And_Today__C) - 1), '0'))
			,CONVERT(INT,ISNULL(SUBSTRING([Source].Days_Since_Note_Created__c, 1, CHARINDEX('.', [Source].Days_Since_Note_Created__c) - 1), '0'))
			,CONVERT(INT,ISNULL(SUBSTRING([Source].Days_since_last_assessment__c, 1, CHARINDEX('.', [Source].Days_since_last_assessment__c) - 1), '0'))

			,[Source].Explain_Why_Perp_Attended_Interview__c,[Source].Interview_Conducted_With__c,[Source].Non_Participating_Contact__c

			,[Source].Note_Created_Contact_Date__c,[Source].Note_Type__c,[Source].Note__c,[Source].TemporaryAPSCase__c,[Source].Case_Note_Created_in_Error__c,[Source].Case_Note__c

			,[Source].[Status__c],[Source].Supervisor_Email__c,[Source].Created_in_Error_Formatted__c
			
			,[Source].Parent__c
		)
;