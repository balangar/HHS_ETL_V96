CREATE TABLE [Staging].[Contacts] (
    [ContactKey]                     INT            IDENTITY (1, 1) NOT NULL,
    [SysInsertUser]                  VARCHAR (18)   CONSTRAINT [DF__tmp_ms_xx__SysIn__4CA06362] DEFAULT ('System') NOT NULL,
    [SysInsertDate]                  DATETIME       CONSTRAINT [DF__tmp_ms_xx__SysIn__4D94879B] DEFAULT (getdate()) NOT NULL,
    [HashSignature]                  AS             (hashbytes('SHA1',(((((((((((((((((((((((((((((((((isnull([ID],'')+isnull([CreatedByID],''))+CONVERT([varchar],isnull([CreatedDate],'1900-01-01'),(121)))+isnull([LastModifiedById],''))+CONVERT([varchar],isnull([SystemModstamp],'1900-01-01'),(121)))+CONVERT([varchar],isnull([IsDeleted],(0))))+isnull([OwnerID],''))+isnull([AccountId],''))+isnull([MasterRecordId],''))+isnull([Salutation],''))+isnull([FirstName],''))+isnull([LastName],''))+isnull([Name],''))+isnull([MailingStreet],''))+isnull([MailingCity],''))+isnull([MailingStateCode],''))+isnull([MailingPostalCode],''))+isnull([MailingAddress],''))+isnull([Phone],''))+isnull([HomePhone],''))+isnull([Email],''))+CONVERT([varchar],isnull([Birthdate],'1900-01-01'),(121)))+CONVERT([varchar],isnull([Approx_Age__c],'0.0')))+isnull([Gender_Code__c],''))+isnull([Gender__c],''))+CONVERT([varchar],isnull([Hoarding_or_animal_hoarding__c],(0))))+isnull([Income_Source__c],''))+isnull([Marital_Status__c],''))+isnull([Medicaid__c],''))+isnull([Medicare__c],''))+isnull([Race__c],''))+isnull([SSN__c],''))+isnull([Person_Id__c],''))+isnull([Veteran_Status__c],''))+CONVERT([varchar],isnull([Bed_Bugs__c],(0))))),

    [ID]                             VARCHAR (18)   NOT NULL,
    [CreatedByID]                    VARCHAR (18)   NULL,
    [CreatedDate]                    DATETIME       NULL,
    [LastModifiedById]               VARCHAR (18)   NULL,
    [LastModifiedDate]               DATETIME       NULL,
    [SystemModstamp]                 DATETIME       NULL,

    [OwnerId]                        VARCHAR (18)   NULL,
    [AccountId]                      VARCHAR (18)   NULL,
    [MasterRecordId]                 VARCHAR (18)   NULL,

    [IsDeleted]                      BIT            NULL,

    [Salutation]                     VARCHAR (40)   NULL,
    [FirstName]                      VARCHAR (40)   NULL,
    [LastName]                       VARCHAR (80)   NULL,
    [Name]                           VARCHAR (128)  NULL,
    [MailingStreet]                  VARCHAR (255)  NULL,
    [MailingCity]                    VARCHAR (50)   NULL,
    [MailingStateCode]               VARCHAR (10)   NULL,
    [MailingPostalCode]              VARCHAR (20)   NULL,
    [MailingAddress]                 VARCHAR (MAX)  NULL,
    [Phone]                          VARCHAR (50)   NULL,
    [HomePhone]                      VARCHAR (50)   NULL,
    [Email]                          VARCHAR (80)   NULL,
    [Birthdate]                      VARCHAR (255)  NULL,
    [Approx_Age__c]                  VARCHAR (255)  NULL,
    [Gender_Code__c]                 VARCHAR (1500) NULL,
    [Gender__c]                      VARCHAR (255)  NULL,
    [Hoarding_or_animal_hoarding__c] BIT            NULL,
    [Income_Source__c]               VARCHAR (4098) NULL,
    [Marital_Status__c]              VARCHAR (255)  NULL,
    [Medicaid__c]                    VARCHAR (255)  NULL,
    [Medicare__c]                    VARCHAR (255)  NULL,
    [Race__c]                        VARCHAR (1500) NULL,
    [SSN__c]                         VARCHAR (50)   NULL,
    [Person_Id__c]                   VARCHAR (30)   NULL,
    [Veteran_Status__c]              VARCHAR (255)  NULL,
    [Bed_Bugs__c]                    BIT            NULL,

    [IsValid]                        BIT            CONSTRAINT [DF_Contacts_IsValid] DEFAULT ((1)) NOT NULL,
    [IsLoaded]                       BIT            CONSTRAINT [DF_Contacts_IsLoaded_1] DEFAULT ((0)) NOT NULL,
    [LoadDate]                       DATETIME       CONSTRAINT [DF_Contacts_IsLoaded] DEFAULT ((0)) NULL,
    [Comments]                       VARCHAR (1024) NULL,

    CONSTRAINT [PK_Contacts] PRIMARY KEY CLUSTERED ([ContactKey] ASC)
);



