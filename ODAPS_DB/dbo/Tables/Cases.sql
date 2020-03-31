﻿CREATE TABLE [dbo].[Cases]
(
	[CaseKey] INT IDENTITY(1,1) NOT NULL,
	[SysInsertUser] VARCHAR(50)		NOT NULL DEFAULT 'Sys_ETL',
	[SysInsertDate] DATETIME		NOT NULL DEFAULT getdate(),
	[SysModifyUser] VARCHAR(50)		NOT NULL DEFAULT 'Sys_Etl',
	[SysModifyDate]	DATETIME		NOT NULL DEFAULT getdate(),
	[HashSignature]	VARBINARY(8000)	NULL,

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

    [Status__c]						   VARCHAR (255)  NULL,
    [Case_Stage__c]					   VARCHAR (255)  NULL,
    [Date_Case_Closed__c]			   VARCHAR (50)	  NULL,
    [Days_Open__c]					   VARCHAR (50)	  NULL,

    [Name]                             VARCHAR (80)   NULL,
    [ContactPersonID]                  VARCHAR (50)   NULL,
    [CaseSeqNo]                        VARCHAR (30)   NULL,
    [Approximate_Age__c]               DECIMAL(5,2)   NULL,
    [Caretaker_Neglect__c]             BIT            NOT NULL,
	[Case_Closed_Reason__c]			   VARCHAR(255)	  NULL,
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
	[Case_Decision_Date_Time__c]	   DATETIME		  NULL,

	CONSTRAINT [PK_Cases] PRIMARY KEY CLUSTERED ([CaseKey] ASC)

)