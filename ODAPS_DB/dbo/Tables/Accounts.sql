CREATE TABLE [dbo].[Accounts]
(
	[AccountKey] [int] IDENTITY(1,1) NOT NULL,
	[SysInsertUser] [varchar](50) NOT NULL DEFAULT 'Sys_ETL',
	[SysInsertDate] [datetime] NOT NULL,

	[ID] [char](18),
	[CreatedByID] [char](18) NULL,
	[CreatedDate] [date],
	[LastModifiedById] [char](18) NULL,
	[LastModifiedDate] [date]
	[SystemModstamp] [date]
	[IsDeleted] [bit],

	[MasterRecordID] [char](18) NULL,
	[OwnerID] [char](18) NULL,
	[ParentID] [char](18) NULL,
	[RecordTypeID] [char](18) NULL,
	[Type] [varchar](40) NULL,

	[Name] [varchar](255) NULL,
	[Description] [varchar](4096) NULL,

	[LastActivityDate] [date] NULL,
	[LastViewedDate][date] NULL,
	[LastReferencedDate] [date] NULL,

	CONSTRAINT [PK_Accounts] PRIMARY KEY CLUSTERED ([AccountKey] ASC)
)
