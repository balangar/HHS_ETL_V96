CREATE TABLE [dbo].[Contacts]
(
    [ContactKey]                     INT            IDENTITY (1, 1) NOT NULL,
    [SysInsertUser]                  VARCHAR (18)   NOT NULL DEFAULT 'Sys_ETL',
    [SysInsertDate]                  DATETIME       NOT NULL DEFAULT  getdate(),
	[SysModifyUser]					 VARCHAR(50)	NULL,
	[SysModifyDate]					 DATETIME		NULL,
    [HashSignature]                  AS             (hashbytes('SHA1',(((((((((((((((((((((((((((((((((isnull([ID],'')+isnull([CreatedByID],''))+CONVERT([varchar],isnull([CreatedDate],'1900-01-01'),(121)))+isnull([LastModifiedById],''))+CONVERT([varchar],isnull([SystemModstamp],'1900-01-01'),(121)))+CONVERT([varchar],isnull([IsDeleted],(0))))+isnull([OwnerID],''))+isnull([AccountId],''))+isnull([MasterRecordId],''))+isnull([Salutation],''))+isnull([FirstName],''))+isnull([LastName],''))+isnull([Name],''))+isnull([MailingStreet],''))+isnull([MailingCity],''))+isnull([MailingStateCode],''))+isnull([MailingPostalCode],''))+isnull([MailingAddress],''))+isnull([Phone],''))+isnull([HomePhone],''))+isnull([Email],''))+CONVERT([varchar],isnull([Birthdate],'1900-01-01'),(121)))+CONVERT([varchar],isnull([Approx_Age__c],'0.0')))+isnull([Gender_Code__c],''))+isnull([Gender__c],''))+CONVERT([varchar],isnull([Hoarding_or_animal_hoarding__c],(0))))+isnull([Income_Source__c],''))+isnull([Marital_Status__c],''))+isnull([Medicaid__c],''))+isnull([Medicare__c],''))+isnull([Race__c],''))+isnull([SSN__c],''))+isnull([Person_Id__c],''))+isnull([Veteran_Status__c],''))+CONVERT([varchar],isnull([Bed_Bugs__c],(0))))),

    [ID]                             CHAR(18)   NOT NULL,
    [CreatedByID]                    CHAR(18)   NOT NULL,
    [CreatedDate]                    DATE		NOT NULL,
    [LastModifiedById]               CHAR(18)   NOT NULL,
    [LastModifiedDate]               DATE		NOT NULL,
    [SystemModstamp]                 DATE		NOT NULL,
    [IsDeleted]                      BIT        NOT NULL,

    [OwnerId]                        CHAR(18)	NOT	NULL,
    [AccountId]                      CHAR(18)	NULL,
    [MasterRecordId]                 CHAR(18)   NULL,

    [Salutation]                     VARCHAR (40)   NULL,
    [FirstName]                      VARCHAR (40)   NULL,
    [LastName]                       VARCHAR (80)   NOT	NULL,
    [Name]                           VARCHAR (128)  NOT NULL,
    [MailingStreet]                  VARCHAR (255)  NULL,
    [MailingCity]                    VARCHAR (50)   NULL,
    [MailingStateCode]               VARCHAR (10)   NULL,
    [MailingPostalCode]              VARCHAR (20)   NULL,
    [MailingAddress]                 VARCHAR (MAX)  NULL,
    [Phone]                          VARCHAR (50)   NULL,
    [HomePhone]                      VARCHAR (50)   NULL,
    [Email]                          VARCHAR (80)   NULL,

    [Birthdate]                      DATE			NULL,
    [Approx_Age__c]                  DECIMAL(4,2)	NULL,
    [Gender_Code__c]                 VARCHAR (1500) NULL,
    [Gender__c]                      VARCHAR (255)  NULL,

    [Hoarding_or_animal_hoarding__c] BIT            NOT	NULL,
    [Income_Source__c]               VARCHAR (4098) NULL,
    [Marital_Status__c]              VARCHAR (255)  NULL,
    [Medicaid__c]                    VARCHAR (255)  NULL,
    [Medicare__c]                    VARCHAR (255)  NULL,
    [Race__c]                        VARCHAR (1500) NULL,
    [SSN__c]                         VARCHAR (50)   NULL,
    [Person_Id__c]                   VARCHAR (30)   NULL,
    [Veteran_Status__c]              VARCHAR (255)  NOT	NULL,
    [Bed_Bugs__c]                    BIT            NOT	NULL,

	CONSTRAINT [PK_Contacts] PRIMARY KEY CLUSTERED ([ContactKey] ASC)

);