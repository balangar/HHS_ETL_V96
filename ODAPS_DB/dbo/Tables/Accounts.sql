CREATE TABLE [dbo].[Accounts](
	[AccountKey] INT IDENTITY(1,1)  NOT NULL,
	[SysInsertUser] VARCHAR(50)		NOT NULL DEFAULT 'Sys_ETL',
	[SysInsertDate] DATETIME		NOT NULL DEFAULT getdate(),
	[SysModifyUser] VARCHAR(50)		NOT NULL DEFAULT 'Sys_Etl',
	[SysModifyDate]	DATETIME		NOT NULL DEFAULT getdate(),
	[HashSignature]	VARBINARY(8000)	NULL,

	[ID] [varchar](18) NULL,
	[CreatedByID] [char](18) NULL,
	[CreatedDate] [date] NULL,
	[LastModifiedById] [char](18) NULL,
	[LastModifiedDate] [date] NULL,
	[SystemModstamp] [datetime] NULL,

	[IsDeleted] [bit] NULL,

	[MasterRecordID] [varchar](18) NULL,
	[OwnerID] [varchar](18) NULL,
	[ParentID] [varchar](18) NULL,
	[RecordTypeID] [varchar](18) NULL,

	[Type] [varchar](40) NULL,
	[Name] [varchar](255) NULL,
	[Description] [varchar](4096) NULL,

	[LastActivityDate] [varchar](50) NULL,
	[LastViewedDate] [varchar](50) NULL,
	[LastReferencedDate] [varchar](50) NULL,

	CONSTRAINT [PK_Accounts] PRIMARY KEY CLUSTERED ([AccountKey] ASC)

	)
 ;

