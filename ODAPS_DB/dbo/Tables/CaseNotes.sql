CREATE TABLE [dbo].[CaseNotes]
(
	[CaseNoteKey] INT IDENTITY(1,1) NOT NULL,
	[SysInsertUser] VARCHAR(50)		NOT NULL DEFAULT 'Sys_ETL',
	[SysInsertDate] DATETIME		NOT NULL DEFAULT getdate(),
	[SysModifyUser] VARCHAR(50)		NOT NULL DEFAULT 'Sys_Etl',
	[SysModifyDate]	DATETIME		NOT NULL DEFAULT getdate(),
	[HashSignature]					AS	HashBytes('SHA1', 
										IsNull(ID, '') +
										Convert(varchar, ISNull(CreatedDate, '1900-01-01')) +
										IsNull(CreatedByID, '') +
										CONVERT(VARCHAR, ISNULL(LastModifiedDate, '1900-01-01')) +
										ISNULL(LastModifiedById, '') +
										CONVERT(VARCHAR, ISNULL(SystemModstamp, '')) +
										CONVERT(VARCHAR, ISNULL(IsDeleted, 0)) +
										ISNULL(RecordTypeId, '') +
										ISNULL(Name, '') +
										CONVERT(VARCHAR, ISNULL(LastActivityDate, '1900 -01-01')) +
										CONVERT(VARCHAR, ISNULL(LastViewedDate, '1900-01-01')) +
										CONVERT(VARCHAR, ISNULL(LastReferencedDate, '1900-01-01')) +
										ISNULL(APS_Case_Number__c, '') +
										ISNULL(APSClientName__c, '') +
										ISNULL(Case_Note_Create_Date_Only__c, '') +
										CONVERT(VARCHAR, ISNULL(Case_Note_Interview_Date__c, '1900-01-01')) +
										ISNULL(Characters_in_Note_Text__c, '') +
										ISNULL(Client_Interview_Outside_Perp_Presence__c, '') +
										CONVERT(VARCHAR, ISNULL(Client_Interview__c, 0)) +
										ISNULL(Client_Name__c, '') +
										ISNULL(Contact_is_Timely__c, '') +
										ISNULL(Copy_of_first_255_char_in_note__c, '') +
										ISNULL(Days_Between_Contact_and_Today__c, '') +
										ISNULL(Days_Since_Note_Created__c, '') +
										ISNULL(Days_since_last_assessment__c, '') +
										ISNULL(Explain_Why_Perp_Attended_Interview__c, '') +
										ISNULL(Interview_Conducted_With__c, '') +
										ISNULL(Non_Participating_Contact__c, '') +
										CONVERT(VARCHAR, ISNULL(Note_Created_Contact_Date__c, '1900-01-01')) +
										ISNULL(Note_Type__c, '') +
										ISNULL(Note__c, '') +
										ISNULL(TemporaryAPSCase__c, '') +
										CONVERT(VARCHAR, ISNULL(Case_Note_Created_in_Error__c, 0)) +
										ISNULL(Case_Note__c, '') +
										ISNULL(Status__c, '') +
										ISNULL(Supervisor_Email__c, '') +
										ISNULL(Created_in_Error_Formatted__c, '')
										),

	
	[Id]										VARCHAR(18)	NOT NULL,
	[CreatedDate]								DATETIME	NOT NULL,
	[CreatedById]								VARCHAR(18)	NOT NULL,
	[LastModifiedDate]							DATETIME	NOT NULL,
	[LastModifiedById]							VARCHAR(18) NOT NULL,
	[SystemModstamp]							DATETIME	NOT NULL,

	[IsDeleted]									BIT			NOT NULL,

	[RecordTypeId]								VARCHAR(18)	NULL,

	[Name]										VARCHAR(80)	NULL,

	[LastActivityDate]							DATE		NULL,
	[LastViewedDate]							DATETIME	NULL,
	[LastReferencedDate]						DATETIME	NULL,

	[APS_Case_Number__c]						VARCHAR(18)	NOT NULL,
	[APSClientName__c]							VARCHAR(100)	NULL,
	[Case_Note_Create_Date_Only__c]				DATE			NULL,
	[Case_Note_Interview_Date__c]				DATE			NULL,
	[Characters_in_Note_Text__c]				INT				NULL,
	[Client_Interview_Outside_Perp_Presence__c]	VARCHAR(255)	NULL,
	[Client_Interview__c]						BIT				NOT NULL,
	[Client_Name__c]							VARCHAR(1300)	NULL,
	[Contact_is_Timely__c]						VARCHAR(255)	NULL,
	[Copy_of_first_255_char_in_note__c]			VARCHAR(255)	NULL,
	[Days_Between_Contact_and_Today__c]			INT				NULL,
	[Days_Since_Note_Created__c]				INT				NULL,
	[Days_since_last_assessment__c]				INT				NULL,
	[Explain_Why_Perp_Attended_Interview__c]	VARCHAR(500)	NULL,
	[Interview_Conducted_With__c]				VARCHAR(18)		NULL,
	[Non_Participating_Contact__c]				VARCHAR(100)	NULL,

	[Note_Created_Contact_Date__c]				VARCHAR(50)		NULL,	-- doc says "double"

	[Note_Type__c]								VARCHAR(50)		NULL,
	[Note__c]									VARCHAR(8000)	NULL,
	[TemporaryAPSCase__c]						VARCHAR(18)		NULL,
	[Case_Note_Created_in_Error__c]				BIT				NOT NULL,
	[Case_Note__c]								VARCHAR(18)		NULL,
	[Status__c]									VARCHAR(50)		NULL,
	[Supervisor_Email__c]						VARCHAR(80)		NULL,
	[Created_in_Error_Formatted__c]				VARCHAR(1300)	NULL,
	[Parent__c]									VARCHAR(1300)	NULL,

	CONSTRAINT [PK_CaseNotes] PRIMARY KEY CLUSTERED ([CaseNoteKey] ASC)
)
