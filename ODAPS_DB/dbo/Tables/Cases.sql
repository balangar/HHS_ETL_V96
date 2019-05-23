CREATE TABLE [dbo].[Cases]
(
	[CaseKey] INT IDENTITY(1,1) NOT NULL,
	[SysInsertUser] VARCHAR(50) NOT NULL DEFAULT 'Sys_ETL',
	[SysInsertDate] DATETIME NOT NULL DEFAULT getdate(),
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

	[ID] CHAR(18) NOT NULL,
	[CreatedByID] CHAR(18) NOT NULL,
	[CreatedDate] DATE NOT NULL,
	[LastModifiedByID] CHAR(18) NOT NULL,
	[LastModifiedDate] DATE NOT NULL,
	[SystemModstamp] DATETIME NOT NULL,

    [OwnerId]                          CHAR (18)   NOT NULL,
    [RecordTypeID]                     CHAR (18)   NULL,
    [Owner_County__c]                  VARCHAR (255)  NULL,
    [IsDeleted]                        BIT            NOT NULL,
    [Name]                             VARCHAR (80)   NULL,
    [ContactPersonID]                  VARCHAR (50)   NULL,
    [CaseSeqNo]                        VARCHAR (30)   NULL,
    [Approximate_Age__c]               DECIMAL(4,2)   NULL,
    [Caretaker_Neglect__c]             BIT            NOT NULL,
    [Client_Address__c]                VARCHAR (255)  NULL,
    [Client_Name__c]                   VARCHAR (18)   NULL,
    [Client_s_Age__c]                  VARCHAR (50)   NULL,
    [Client_s_Home_Phone_Number__c]    VARCHAR (255)  NULL,
    [Date_of_Birth__c]                 VARCHAR (50)   NULL,
    [Exploitation__c]                  BIT            NOT NULL,
    [Gender_Code__c]                   VARCHAR (255)  NULL,
    [Marital_Status_Code__c]           VARCHAR (255)  NULL,
    [Physical_Abuse__c]                BIT            NOT NULL,
    [Reporting_Party_Agency_Name__c]   VARCHAR (255)  NULL,
    [Reporting_Party_Name__c]          VARCHAR (18)   NULL,
    [Self_Neglect__c]                  BIT            NOT NULL,
    [Sexual_Abuse__c]                  BIT            NOT NULL,
    [Supervisor_E_mail__c]             VARCHAR (80)   NULL,
    [Supervisor_Name__c]               VARCHAR (255)  NULL,
    [Supervisor__c]                    VARCHAR (18)   NULL,
    [Hoarding_or_animal_hoarding__c]   BIT            NOT NULL,
    [Emotional_Verbal_Abuse__c]        BIT            NOT NULL,
    [Referral_Submitted_Date_Time__c]  VARCHAR (50)   NULL,
    [Bed_Bugs__c]                      BIT            NOT NULL,
    [Substance_abuse__c]               BIT            NOT NULL,
    [Diagnosed_Mental_Illness_Info__c] VARCHAR (4096) NULL,
    [Diagnosed_Mental_Illness__c]      VARCHAR (255)  NULL,

	CONSTRAINT [PK_Cases] PRIMARY KEY CLUSTERED ([CaseKey] ASC)

)