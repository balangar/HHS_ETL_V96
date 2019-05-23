CREATE TABLE [Staging].[Cases] (
    [CaseKey]                          INT            IDENTITY (1, 1) NOT NULL,
    [SysInsertUser]                    VARCHAR (50)   CONSTRAINT [DF__Cases__SysInsert__3493CFA7] DEFAULT ('System') NOT NULL,
    [SysInsertDate]                    DATETIME       CONSTRAINT [DF__Cases__SysInsert__3587F3E0] DEFAULT (getdate()) NOT NULL,
	HASHBYTES('SHA1',
				ISNULL(ID, '') +
				ISNULL(CreatedByID, '') +
				CONVERT(varchar, ISNULL(CreatedDate, '1900-01-01'), 121) +
				ISNULL(LastModifiedById, '') +
				CONVERT(varchar, ISNULL(SystemModstamp, '1900-01-01'), 121) +
				CONVERT(varchar, ISNULL(IsDeleted, 0)) +
				ISNULL(OwnerID,'') +
				ISNULL(RecordTypeID, '') +
				ISNULL(Owner_County__c, '') +
				ISNULL([Name], '') +
				ISNULL(ContactPersonID, '') +
				ISNULL(CaseSeqNo, '') +
				CONVERT(varchar, ISNULL(Approximate_Age__c, '')) +
				CONVERT(varchar, ISNULL(Caretaker_Neglect__c, '')) +
				ISNULL(Client_Address__c, '') +
				ISNULL(Client_s_Age__c, '') +
				ISNULL(Client_s_Home_Phone_Number__c, '') +
				CONVERT(varchar, ISNULL(Date_of_Birth__c, '1900-01-01'), 121) +
				CONVERT(varchar, ISNULL(Exploitation__c, 0)) +
				ISNULL(Gender_Code__c, '') +
				ISNULL(Marital_Status_Code__c, '') +
				CONVERT(varchar, ISNULL(Physical_Abuse__c, 0)) +
				ISNULL(Reporting_Party_Agency_Name__c, '') +
				ISNULL(Reporting_Party_Name__c, '') +
				CONVERT(varchar, ISNULL(Self_Neglect__c, 0)) +
				CONVERT(varchar, ISNULL(Sexual_Abuse__c, 0)) +
				ISNULL(Supervisor_E_mail__c, '') +
				ISNULL(Supervisor_Name__c, '') +
				ISNULL(Supervisor__c, '') +
				CONVERT(varchar, ISNULL(Hoarding_or_animal_hoarding__c, 0)) +
				CONVERT(varchar, ISNULL(Emotional_Verbal_Abuse__c, 0)) +
				CONVERT(varchar, ISNULL(Referral_Submitted_Date_Time__c, '1900-01-01'), 121) +
				CONVERT(varchar, ISNULL(Bed_Bugs__c, 0)) +
				CONVERT(varchar, ISNULL(Substance_abuse__c, 0)) +
				ISNULL(Diagnosed_Mental_Illness_Info__c, '') +
				ISNULL(Diagnosed_Mental_Illness__c, '')
				) As HashSignature,

    [ID]                               VARCHAR (18)   NULL,
    [CreatedById]                      VARCHAR (18)   NULL,
    [CreatedDate]                      VARCHAR (50)   NULL,
    [LastModifiedById]                 VARCHAR (18)   NOT NULL,
    [LastModifiedDate]                 VARCHAR (50)   NOT NULL,
    [SystemModStamp]                   VARCHAR (50)   NOT NULL,
    [OwnerId]                          VARCHAR (18)   NULL,
    [RecordTypeID]                     VARCHAR (18)   NULL,
    [Owner_County__c]                  VARCHAR (255)  NULL,
    [IsDeleted]                        BIT            NULL,
    [Name]                             VARCHAR (80)   NULL,
    [ContactPersonID]                  VARCHAR (50)   NULL,
    [CaseSeqNo]                        VARCHAR (30)   NULL,
    [Approximate_Age__c]               VARCHAR (50)   NULL,
    [Caretaker_Neglect__c]             BIT            NULL,
    [Client_Address__c]                VARCHAR (255)  NULL,
    [Client_Name__c]                   VARCHAR (18)   NULL,
    [Client_s_Age__c]                  VARCHAR (50)   NULL,
    [Client_s_Home_Phone_Number__c]    VARCHAR (255)  NULL,
    [Date_of_Birth__c]                 VARCHAR (50)   NULL,
    [Exploitation__c]                  BIT            NULL,
    [Gender_Code__c]                   VARCHAR (255)  NULL,
    [Marital_Status_Code__c]           VARCHAR (255)  NULL,
    [Physical_Abuse__c]                BIT            NULL,
    [Reporting_Party_Agency_Name__c]   VARCHAR (255)  NULL,
    [Reporting_Party_Name__c]          VARCHAR (18)   NULL,
    [Self_Neglect__c]                  BIT            NULL,
    [Sexual_Abuse__c]                  BIT            NULL,
    [Supervisor_E_mail__c]             VARCHAR (80)   NULL,
    [Supervisor_Name__c]               VARCHAR (255)  NULL,
    [Supervisor__c]                    VARCHAR (18)   NULL,
    [Hoarding_or_animal_hoarding__c]   BIT            NULL,
    [Emotional_Verbal_Abuse__c]        BIT            NULL,
    [Referral_Submitted_Date_Time__c]  VARCHAR (50)   NULL,
    [Bed_Bugs__c]                      BIT            NULL,
    [Substance_abuse__c]               BIT            NULL,
    [Diagnosed_Mental_Illness_Info__c] VARCHAR (4096) NULL,
    [Diagnosed_Mental_Illness__c]      VARCHAR (255)  NULL,
    [IsValid]                          BIT            CONSTRAINT [DF__Cases__IsValid__367C1819] DEFAULT ((1)) NOT NULL,
    [IsLoaded]                         BIT            CONSTRAINT [DF__Cases__IsLoaded__37703C52] DEFAULT ((0)) NOT NULL,
    [LoadDate]                         DATETIME       CONSTRAINT [DF_Cases_LoadDate] DEFAULT ('1900-01-01') NOT NULL,
    [Comments]                         VARCHAR (1024) NULL,
    CONSTRAINT [PK_Cases] PRIMARY KEY CLUSTERED ([CaseKey] ASC)
);




