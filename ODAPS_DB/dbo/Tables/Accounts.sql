CREATE TABLE [dbo].[Accounts](
	[AccountKey] [int] IDENTITY(1,1) NOT NULL,
	[SysInsertUser] [varchar](50) NOT NULL DEFAULT  'Sys_ETL',
	[SysInsertDate] [datetime] NOT NULL DEFAULT getdate(),
	[SysModifyUser] VARCHAR(50) NULL,
	[SysModifyDate]	DATETIME	NULL,
	[HashSignature]  AS (hashbytes('SHA1',((((((((((((((isnull([ID],'')+isnull([CreatedByID],''))+CONVERT([varchar],isnull([CreatedDate],'1900-01-01'),(121)))+isnull([LastModifiedById],''))+CONVERT([varchar],isnull([SystemModstamp],'1900-01-01'),(121)))+CONVERT([varchar],isnull([IsDeleted],(0))))+isnull([MasterRecordID],''))+isnull([OwnerID],''))+isnull([ParentID],''))+isnull([RecordTypeID],''))+isnull([Name],''))+isnull([Type],''))+isnull([Description],''))+CONVERT([varchar],isnull([LastActivityDate],'1900-01-01'),(121)))+CONVERT([varchar],isnull([LastViewedDate],'1900-01-01'),(121)))+CONVERT([varchar],isnull([LastReferencedDate],'1900-01-01'),(121)))),

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

