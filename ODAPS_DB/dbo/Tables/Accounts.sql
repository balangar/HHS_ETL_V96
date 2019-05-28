CREATE TABLE [dbo].[Accounts] (
    [AccountKey]         INT            IDENTITY (1, 1) NOT NULL,
    [SysInsertUser]      VARCHAR (50)   CONSTRAINT [DF__Accounts__SysIns__05A3D694] DEFAULT ('Sys_ETL') NOT NULL,
    [SysInsertDate]      DATETIME       CONSTRAINT [DF_Accounts_SysInsertDate] DEFAULT (getdate()) NOT NULL,
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
		) As HashSignature,

    [ID]                 VARCHAR (18)   NULL,
    [CreatedByID]        CHAR (18)      NULL,
    [CreatedDate]        DATE           NULL,
    [LastModifiedById]   CHAR (18)      NULL,
    [LastModifiedDate]   DATE           NULL,
    [SystemModstamp]     DATETIME       NULL,

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

    CONSTRAINT [PK_Accounts] PRIMARY KEY CLUSTERED ([AccountKey] ASC)
);


