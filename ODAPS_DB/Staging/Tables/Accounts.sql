﻿CREATE TABLE [Staging].[Accounts] (
    [AccountKey]         INT            IDENTITY (1, 1) NOT NULL,
    [SysInsertUser]      VARCHAR (50)   CONSTRAINT [DF__Accounts__SysIns__4A8310C6] DEFAULT ('System') NOT NULL,
    [SysInsertDate]      DATETIME       CONSTRAINT [DF__Accounts__SysIns__4B7734FF] DEFAULT (getdate()) NOT NULL,
    [HashSignature]      AS             (hashbytes('SHA1',((((((((((((((isnull([ID],'')+isnull([CreatedByID],''))+CONVERT([varchar],isnull([CreatedDate],'1900-01-01'),(121)))+isnull([LastModifiedById],''))+CONVERT([varchar],isnull([SystemModstamp],'1900-01-01'),(121)))+CONVERT([varchar],isnull([IsDeleted],(0))))+isnull([MasterRecordID],''))+isnull([OwnerID],''))+isnull([ParentID],''))+isnull([RecordTypeID],''))+isnull([Name],''))+isnull([Type],''))+isnull([Description],''))+CONVERT([varchar],isnull([LastActivityDate],'1900-01-01'),(121)))+CONVERT([varchar],isnull([LastViewedDate],'1900-01-01'),(121)))+CONVERT([varchar],isnull([LastReferencedDate],'1900-01-01'),(121)))) PERSISTED,
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
    [IsValid]            BIT            CONSTRAINT [DF__Accounts__IsVali__4C6B5938] DEFAULT ((1)) NOT NULL,
    [IsLoaded]           BIT            CONSTRAINT [DF__Accounts__IsLoad__4D5F7D71] DEFAULT ((0)) NOT NULL,
    [LoadDate]           DATETIME       CONSTRAINT [DF_Accounts_LoadDate] DEFAULT ('1900-01-01') NULL,
    [Comments]           VARCHAR (1024) NULL,
    CONSTRAINT [PK_Accounts] PRIMARY KEY CLUSTERED ([AccountKey] ASC)
);





