CREATE TABLE [Staging].[Contacts] (
    [ContactKey]                     INT            IDENTITY (1, 1) NOT NULL PRIMARY KEY,
    [SysInsertUser]                  VARCHAR (18)   CONSTRAINT [DF__tmp_ms_xx__SysIn__4CA06362] DEFAULT ('System') NOT NULL,
    [SysInsertDate]                  DATETIME       CONSTRAINT [DF__tmp_ms_xx__SysIn__4D94879B] DEFAULT (getdate()) NOT NULL,
    [HashSignature]                  AS             HashBytes('SHA1', 
													IsNull(ID, '') +
													IsNull(CreatedByID, '') +
													Convert(varchar, ISNull(CreatedDate, '1900-01-01')) +
													ISNULL(LastModifiedById, '') +
													CONVERT(VARCHAR, ISNULL(LastModifiedDate, '1900-01-01')) +
													CONVERT(VARCHAR, ISNULL(SystemModstamp, '')) +
													CONVERT(VARCHAR, ISNULL(IsDeleted, 0)) +
													ISNULL(OwnerID, '') +
													ISNULL(AccountID, '') +
													ISNULL(MasterRecordId, '') +
													ISNULL(Salutation, '') +
													ISNULL(FirstName, '') +
													ISNULL(LastName, '') +
													ISNULL(Name, '') +
													ISNULL(MailingStreet, '') +
													ISNULL(MailingCity, '') +
													ISNULL(MailingStateCode, '') +
													ISNULL(MailingPostalCode, '') +
													ISNULL(MailingAddress, '') +
													ISNULL(Phone, '') +
													ISNULL(HomePhone, '') +
													ISNULL(Email, '') +
													CONVERT(VARCHAR, ISNULL(Birthdate, '1900-01-01')) +
													ISNULL(Approx_Age__c, '0.0') +
													ISNULL(Gender_Code__c, '') +
													ISNULL(Gender__c, '') +
													CONVERT(VARCHAR, ISNULL(Hoarding_or_animal_hoarding__c, 0)) +
													ISNULL(Income_Source__c, '') +
													ISNULL(Marital_Status__c, '') +
													ISNULL(Medicaid__c, '') +
													ISNULL(Medicare__c, '') +
													ISNULL(Race__c, '') +
													ISNULL(SSN__c, '') +
													ISNULL(Person_Id__c, '') +
													ISNULL(Veteran_Status__c, '') +
													CONVERT(VARCHAR, ISNULL(Bed_Bugs__c, 0))
													),


    [ID]                             VARCHAR (18)   NOT NULL,
    [CreatedByID]                    VARCHAR (18)   NULL,
    [CreatedDate]                    DATETIME       NULL,
    [LastModifiedById]               VARCHAR (18)   NULL,
    [LastModifiedDate]               DATETIME       NULL,
    [SystemModstamp]                 DATETIME       NULL,
    [IsDeleted]                      BIT            NULL,

    [OwnerId]                        VARCHAR (18)   NULL,
    [AccountId]                      VARCHAR (18)   NULL,
    [MasterRecordId]                 VARCHAR (18)   NULL,

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

    [IsValid]                        BIT            NOT NULL DEFAULT 1,
    [IsLoaded]                       BIT            NOT NULL DEFAULT 0,
    [LoadDate]                       DATETIME       NOT NULL DEFAULT '1900-01-01',

    [Comments]                       VARCHAR (1024) NULL
);



