CREATE TABLE [Staging].[Users] (
    [UserKey]          INT            IDENTITY (1, 1) NOT NULL,
    [SysInsertUser]    VARCHAR (50)   CONSTRAINT [DF_Users_SysInsertUser] DEFAULT ('System') NOT NULL,
    [SysInsertDate]    DATETIME       CONSTRAINT [DF_Users_SysInsertDate] DEFAULT (getdate()) NOT NULL,

    [ID]               VARCHAR (18)   NOT NULL,
    [CreatedByID]      CHAR (18)      NULL,
    [CreatedDate]      VARCHAR(50)    NULL,
    [LastModifiedById] CHAR (18)      NULL,
    [LastModifiedDate] VARCHAR(50)    NULL,
    [SystemModstamp]   VARCHAR(50)    NULL,

    [AccountID]        VARCHAR (18)   NULL,
    [ContactID]        VARCHAR (18)   NULL,

    [UserName]         VARCHAR (80)   NULL,
    [FirstName]        VARCHAR (40)   NULL,
    [LastName]         VARCHAR (80)   NULL,
    [Name]             VARCHAR (128)  NULL,
    [EMail]            VARCHAR (128)  NULL,
    [Phone]            VARCHAR (40)   NULL,

    [ManagerID]        VARCHAR (18)   NULL,
    [Supervisor__c]    VARCHAR (18)   NULL,

    [IsValid]          BIT            CONSTRAINT [DF_Users_IsValid] DEFAULT ((1)) NOT NULL,
    [IsLoaded]         BIT            CONSTRAINT [DF_Users_IsLoaded] DEFAULT ((0)) NOT NULL,
    [LoadDate]         DATETIME       CONSTRAINt [DF_Users_LoadDate] DEFAULT '1900-01-01' NOT NULL,
    [Comments]         VARCHAR (1024) NULL,

    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([UserKey] ASC)
);


