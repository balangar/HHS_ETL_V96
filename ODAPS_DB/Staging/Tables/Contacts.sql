CREATE TABLE [Staging].[Contacts](
	[ContactKey] int NOT NULL IDENTITY(1,1),
	[SysInsertUser] [varchar](18) NOT NULL DEFAULT 'System',
	[SysInsertDate] [datetime] NOT NULL DEFAULT getdate(),

	[ID] varchar(18) NOT NULL,
	[CreatedByID] varchar(18) NULL,
	[CreatedDate] [date] NULL,
	[LastModifiedById] varchar(18) NULL,
	[LastModifiedDate] datetime NULL,
	[SystemModstamp] [datetime] NULL,

	[OwnerId] [varchar](18) NULL,
	[AccountId] [varchar](18) NULL,
	[MasterRecordId] [varchar](18) NULL,
	[IsDeleted] bit NULL,

	[LastName] [varchar](80) NULL,
	[FirstName] [varchar](40) NULL,
	[Name] [varchar](128) NULL,

	[MailingStreet] [varchar](255) NULL,
	[MailingCity] [varchar](50) NULL,
	[MailingStateCode] [varchar](10) NULL,
	[MailingPostalCode] [varchar](20) NULL,
	[MailingAddress] [varchar](255) NULL,

	[Phone] [varchar](50) NULL,
	[HomePhone] [varchar](50) NULL,
	[Email] [varchar](80) NULL,

	[Birthdate] date NULL,
	[Approx_Age__c] decimal(18,2) NULL,

	[Gender_Code__c] [varchar](1500) NULL,
	[Gender__c] [varchar](255) NULL,

	[Hoarding_or_animal_hoarding__c] bit NULL,
	[Income_Source__c] [varchar](4098) NULL,
	[Marital_Status__c] [varchar](255) NULL,
	[Medicaid__c] [varchar](255) NULL,
	[Medicare__c] [varchar](255) NULL,
	[Race__c] [varchar](1500) NULL,
	[SSN__c] [varchar](50) NULL,
	[Person_Id__c] [varchar](30) NULL,
	[Veteran_Status__c] [varchar](255) NULL,
	[Bed_Bugs__c] bit NULL,

	CONSTRAINT [PK_Contacts] PRIMARY KEY CLUSTERED ([ContactKey] ASC)

);