USE [DSAS_ODAPS]
GO

ALTER TABLE [Staging].[Cases] DROP CONSTRAINT [DF_Cases_LoadDate]
GO

ALTER TABLE [Staging].[Cases] DROP CONSTRAINT [DF__Cases__IsLoaded__37703C52]
GO

ALTER TABLE [Staging].[Cases] DROP CONSTRAINT [DF__Cases__IsValid__367C1819]
GO

ALTER TABLE [Staging].[Cases] DROP CONSTRAINT [DF__Cases__SysInsert__3587F3E0]
GO

ALTER TABLE [Staging].[Cases] DROP CONSTRAINT [DF__Cases__SysInsert__3493CFA7]
GO

/****** Object:  Table [Staging].[Cases]    Script Date: 4/6/2020 10:12:43 AM ******/
DROP TABLE [Staging].[Cases]
GO

/****** Object:  Table [Staging].[Cases]    Script Date: 4/6/2020 10:12:43 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Staging].[Cases](
	[CaseKey] [int] IDENTITY(1,1) NOT NULL	PRIMARY KEY,
	[SysInsertUser] [varchar](50) NOT NULL	DEFAULT 'System',
	[SysInsertDate] [datetime] NOT NULL		DEFAULT getdate(),
    [HashSignature]                     AS  HashBytes('SHA1', 
                                                    IsNull(ID, '') +
                                                    IsNull(CreatedByID, '') +
                                                    Convert(varchar, ISNull(CreatedDate, '1900-01-01')) +
                                                    ISNULL(LastModifiedById, '') +
                                                    CONVERT(VARCHAR, ISNULL(LastModifiedDate, '1900-01-01')) +
                                                    CONVERT(VARCHAR, ISNULL(SystemModstamp, '')) +
                                                    ISNULL(Status__c, '') +
                                                    ISNULL(Case_Stage__c , '') +
                                                    CONVERT(VARCHAR, ISNULL(IsDeleted, 0)) +
                                                    ISNULL(OwnerID, '') +
                                                    ISNULL(RecordTypeId, '') +
                                                    ISNULL(Owner_County__c, '') +
                                                    CONVERT(VARCHAR, ISNULL(Date_Case_Closed__c, '1900-01-01')) +
                                                    ISNULL(Days_Open__c, '') +
                                                    ISNULL(Name, '') +
                                                    ISNULL(ContactPersonID, '') +
                                                    ISNULL(CaseSeqNo, '') +
                                                    ISNULL(Approximate_Age__c, '') +
                                                    CONVERT(VARCHAR, ISNULL(Caretaker_Neglect__c, 0)) +
                                                    ISNULL(Case_Closed_Reason__c, '') +
                                                    ISNULL(Client_Address__c, '') +
                                                    ISNULL(Client_Name__c, '') +
                                                    ISNULL(Client_s_Age__c, '') +
                                                    ISNULL(Client_s_Home_Phone_Number__c, '') +
                                                    CONVERT(VARCHAR, ISNULL(Date_of_Birth__c, '1900-01-01')) +
                                                    CONVERT(VARCHAR, ISNULL(Exploitation__c, 0)) +
                                                    ISNULL(Gender_Code__c, '') +
                                                    ISNULL(Marital_Status_Code__c, '') +
                                                    CONVERT(VARCHAR, ISNULL(Physical_Abuse__c, 0)) +
                                                    CONVERT(VARCHAR, ISNULL(Report_Effective_Date_Time__c, '1900-01-01')) +
                                                    ISNULL(Reporting_Party_Agency_Name__c, '') +
                                                    ISNULL(Reporting_Party_Name__c, '') +
                                                    ISNULL(Screen_Out_Reason__c, '') +
                                                    CONVERT(VARCHAR, ISNULL(Screened_Out_Date_Time__c, '1900-01-01')) +
                                                    CONVERT(VARCHAR, ISNULL(Self_Neglect__c, 0)) +
                                                    CONVERT(VARCHAR, ISNULL(Sexual_Abuse__c, 0)) +
                                                    ISNULL(Supervisor_E_mail__c, '') +
                                                    ISNULL(Supervisor_Name__c, '') +
                                                    ISNULL(Supervisor__c, '') +
                                                    CONVERT(VARCHAR, ISNULL(Hoarding_or_animal_hoarding__c, 0)) +
                                                    CONVERT(VARCHAR, ISNULL(Emotional_Verbal_Abuse__c, 0)) +
                                                    CONVERT(VARCHAR, ISNULL(Referral_Submitted_Date_Time__c, '1900-01-01')) +
                                                    CONVERT(VARCHAR, ISNULL(Bed_Bugs__c, 0)) +
                                                    CONVERT(VARCHAR, ISNULL(Substance_abuse__c, 0)) +
                                                    ISNULL(Diagnosed_Mental_Illness_Info__c, '') +
                                                    ISNULL(Diagnosed_Mental_Illness__c, '') +
                                                    CONVERT(VARCHAR, ISNULL(Case_Decision_Date_Time__c, '1900-01-01'))
                                                    ),
	[ID] [varchar](18) NULL,
	[CreatedById] [varchar](18) NULL,
	[CreatedDate] [varchar](50) NULL,
	[LastModifiedById] [varchar](18) NOT NULL,
	[LastModifiedDate] [varchar](50) NOT NULL,
	[SystemModStamp] [varchar](50) NOT NULL,

	[Status__c] [varchar](255) NULL,
	[Case_Stage__c] [varchar](255) NULL,
	[Date_Case_Closed__c] [varchar](50) NULL,
	[Days_Open__c] [varchar](50) NULL,

	[OwnerId] [varchar](18) NULL,
	[RecordTypeID] [varchar](18) NULL,
	[Owner_County__c] [varchar](255) NULL,
	[IsDeleted] [bit] NULL,
	[Name] [varchar](80) NULL,
	[ContactPersonID] [varchar](50) NULL,
	[CaseSeqNo] [varchar](30) NULL,
	[Approximate_Age__c] [varchar](50) NULL,
	[Caretaker_Neglect__c] [bit] NULL,
	[Case_Closed_Reason__c] [varchar](255) NULL,
	[Client_Address__c] [varchar](255) NULL,
	[Client_Name__c] [varchar](18) NULL,
	[Client_s_Age__c] [varchar](50) NULL,
	[Client_s_Home_Phone_Number__c] [varchar](255) NULL,
	[Date_of_Birth__c] [varchar](50) NULL,
	[Exploitation__c] [bit] NULL,
	[Gender_Code__c] [varchar](255) NULL,
	[Marital_Status_Code__c] [varchar](255) NULL,
	[Physical_Abuse__c] [bit] NULL,

	[Report_Effective_Date_Time__c] [varchar](50) NULL,

	[Reporting_Party_Agency_Name__c] [varchar](255) NULL,
	[Reporting_Party_Name__c] [varchar](18) NULL,

	[Screen_Out_Reason__c]	VARCHAR (255)  NULL,
    [Screened_Out_Date_Time__c]	VARCHAR (50)	  NULL,

	[Self_Neglect__c] [bit] NULL,
	[Sexual_Abuse__c] [bit] NULL,
	[Supervisor_E_mail__c] [varchar](80) NULL,
	[Supervisor_Name__c] [varchar](255) NULL,
	[Supervisor__c] [varchar](18) NULL,
	[Hoarding_or_animal_hoarding__c] [bit] NULL,
	[Emotional_Verbal_Abuse__c] [bit] NULL,
	[Referral_Submitted_Date_Time__c] [varchar](50) NULL,
	[Bed_Bugs__c] [bit] NULL,
	[Substance_abuse__c] [bit] NULL,
	[Diagnosed_Mental_Illness_Info__c] [varchar](4096) NULL,
	[Diagnosed_Mental_Illness__c] [varchar](255) NULL,
	[Case_Decision_Date_Time__c] [datetime] NULL,
	[IsValid] [bit] NOT NULL	DEFAULT 1,
	[IsLoaded] [bit] NOT NULL	DEFAULT 0,
	[LoadDate] [datetime] NOT NULL	DEFAULT '1900-01-01',
	[Comments] [varchar](1024) NULL
)

GO


