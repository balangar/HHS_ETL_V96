CREATE TABLE [Staging].[Users] (
    [UserKey]          INT            IDENTITY (1, 1) NOT NULL,
    [SysInsertUser]    VARCHAR (50)   CONSTRAINT [DF__Users__SysInsert__5812160E] DEFAULT ('System') NOT NULL,
    [SysInsertDate]    DATETIME       CONSTRAINT [DF__Users__SysInsert__59063A47] DEFAULT (getdate()) NOT NULL,
	[HashSignature]								AS	HashBytes('SHA1', 
													IsNull(ID, '') +
													Convert(varchar, ISNull(CreatedDate, '1900-01-01')) +
													IsNull(CreatedByID, '') +
													CONVERT(VARCHAR, ISNULL(LastModifiedDate, '1900-01-01')) +
													ISNULL(LastModifiedById, '') +
													CONVERT(VARCHAR, ISNULL(SystemModstamp, '')) +
													ISNULL([ID], '') +
													ISNULL([CreatedByID], '') +
													ISNULL([CreatedDate], '') +
													ISNULL([LastModifiedById], '') +
													CONVERT(VARCHAR, ISNULL([LastModifiedDate], '1900-01-01')) +
													ISNULL([SystemModstamp], '') +
													ISNULL([AccountID], '') +
													ISNULL([ContactID], '') +
													ISNULL([UserName], '') +
													ISNULL([FirstName], '') +
													ISNULL([LastName], '') +
													ISNULL([Name], '') +
													ISNULL([EMail], '') +
													ISNULL([Phone], '') +
													ISNULL([ManagerID], '') +
													ISNULL([Supervisor__c], '')
													),
    [ID]               VARCHAR (18)   NULL,
    [CreatedByID]      CHAR (18)      NULL,
    [CreatedDate]      DATE   NULL,
    [LastModifiedById] CHAR (18)      NULL,
    [LastModifiedDate] DATE			  NULL,
    [SystemModstamp]   DATETIME		  NULL,

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
    [LoadDate]         DATETIME       CONSTRAINT [DF_Users_LoadDate] DEFAULT ('1900-01-01') NULL,
    [Comments]         VARCHAR (1024) NULL,

    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([UserKey] ASC)
);




