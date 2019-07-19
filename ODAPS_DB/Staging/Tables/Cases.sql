CREATE TABLE [Staging].[Cases] (
    [CaseKey]                          INT            IDENTITY (1, 1) NOT NULL,
    [SysInsertUser]                    VARCHAR (50)   CONSTRAINT [DF__Cases__SysInsert__3493CFA7] DEFAULT ('System') NOT NULL,
    [SysInsertDate]                    DATETIME       CONSTRAINT [DF__Cases__SysInsert__3587F3E0] DEFAULT (getdate()) NOT NULL,
    [HashSignature]                    AS             (hashbytes('SHA1',((((((((((((((((((((((((((((((((((isnull([ID],'')+isnull([CreatedByID],''))+CONVERT([varchar],isnull([CreatedDate],'1900-01-01'),(121)))+isnull([LastModifiedById],''))+CONVERT([varchar],isnull([SystemModstamp],'1900-01-01'),(121)))+CONVERT([varchar],isnull([IsDeleted],(0))))+isnull([OwnerID],''))+isnull([RecordTypeID],''))+isnull([Owner_County__c],''))+isnull([Name],''))+isnull([ContactPersonID],''))+isnull([CaseSeqNo],''))+CONVERT([varchar],isnull([Approximate_Age__c],'')))+CONVERT([varchar],isnull([Caretaker_Neglect__c],'')))+isnull([Client_Address__c],''))+isnull([Client_s_Age__c],''))+isnull([Client_s_Home_Phone_Number__c],''))+CONVERT([varchar],isnull([Date_of_Birth__c],'1900-01-01'),(121)))+CONVERT([varchar],isnull([Exploitation__c],(0))))+isnull([Gender_Code__c],''))+isnull([Marital_Status_Code__c],''))+CONVERT([varchar],isnull([Physical_Abuse__c],(0))))+isnull([Reporting_Party_Agency_Name__c],''))+isnull([Reporting_Party_Name__c],''))+CONVERT([varchar],isnull([Self_Neglect__c],(0))))+CONVERT([varchar],isnull([Sexual_Abuse__c],(0))))+isnull([Supervisor_E_mail__c],''))+isnull([Supervisor_Name__c],''))+isnull([Supervisor__c],''))+CONVERT([varchar],isnull([Hoarding_or_animal_hoarding__c],(0))))+CONVERT([varchar],isnull([Emotional_Verbal_Abuse__c],(0))))+CONVERT([varchar],isnull([Referral_Submitted_Date_Time__c],'1900-01-01'),(121)))+CONVERT([varchar],isnull([Bed_Bugs__c],(0))))+CONVERT([varchar],isnull([Substance_abuse__c],(0))))+isnull([Diagnosed_Mental_Illness_Info__c],''))+isnull([Diagnosed_Mental_Illness__c],''))) PERSISTED,

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
	[Case_Closed_Reason__c]			   VARCHAR(255)   NULL,
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
	[Case_Decision_Date_Time__c]	   DATETIME		  NULL,

    [IsValid]                          BIT            CONSTRAINT [DF__Cases__IsValid__367C1819] DEFAULT ((1)) NOT NULL,
    [IsLoaded]                         BIT            CONSTRAINT [DF__Cases__IsLoaded__37703C52] DEFAULT ((0)) NOT NULL,
    [LoadDate]                         DATETIME       CONSTRAINT [DF_Cases_LoadDate] DEFAULT ('1900-01-01') NOT NULL,

    [Comments]                         VARCHAR (1024) NULL,
    CONSTRAINT [PK_Cases] PRIMARY KEY CLUSTERED ([CaseKey] ASC)
);




