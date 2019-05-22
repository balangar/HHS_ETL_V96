﻿CREATE TABLE [Staging].[Accounts] (
    [AccountKey]         INT            IDENTITY (1, 1) NOT NULL,
    [SysInsertUser]      VARCHAR (50)   DEFAULT ('System') NOT NULL,
    [SysInsertDate]      DATETIME       DEFAULT (getdate()) NOT NULL,
	HASHBYTES('SHA1',
		ISNULL(ID, '') +
		ISNULL(CreatedByID, '') +
		CONVERT(varchar, ISNULL(CreatedDate, '1900-01-01'), 121) +
		ISNULL(LastModifiedById, '') +
		CONVERT(varchar, ISNULL(SystemModstamp, '1900-01-01'), 121) +
		CONVERT(varchar, ISNULL(IsDeleted, 0)) +
		ISNULL(MasterRecordID, '')  +
		ISNULL(OwnerID,'') +
		ISNULL(ParentID, '') +
		ISNULL(RecordTypeID, '') +
		ISNULL([Type], '') +
		ISNULL([Name], '') + 
		ISNULL([Description], '') +
		CONVERT(varchar, ISNULL(LastActivityDate, '1900-01-01'), 121) +
		CONVERT(varchar, ISNULL(LastViewedDate, '1900-01-01'), 121) +
		CONVERT(varchar, ISNULL(LastReferencedDate, '1900-01-01'), 121)
		) As HashedBytes,
    [ID]                 VARCHAR (18)   NULL,
    [CreatedByID]        CHAR (18)      NULL,
    [CreatedDate]        VARCHAR (50)   NULL,
    [LastModifiedById]   CHAR (18)      NULL,
    [LastModifiedDate]   VARCHAR (50)   NULL,
    [SystemModstamp]     VARCHAR (50)   NULL,
    [IsDeleted]          BIT            NULL,
    [MasterRecordID]     VARCHAR (18)   NULL,
    [OwnerID]            VARCHAR (18)   NULL,
    [ParentID]           VARCHAR (18)   NULL,
    [RecordTypeID]       VARCHAR (18)   NULL,
    [Type]               VARCHAR (40)   NULL,
    [Name]               VARCHAR (255)  NULL,
    [Description]        VARCHAR (4096) NULL,
    [LastActivityDate]   VARCHAR (50)   NULL,
    [LastViewedDate]     VARCHAR (50)   NULL,
    [LastReferencedDate] VARCHAR (50)   NULL,
    [IsValid]            BIT            DEFAULT ((1)) NOT NULL,
    [IsLoaded]           BIT            DEFAULT ((0)) NOT NULL,
    [LoadDate]           DATETIME       CONSTRAINT [DF_Accounts_LoadDate] DEFAULT ('1900-01-01') NULL,
    [Comments]           VARCHAR (1024) NULL,
    CONSTRAINT [PK_Accounts] PRIMARY KEY CLUSTERED ([AccountKey] ASC)
);



