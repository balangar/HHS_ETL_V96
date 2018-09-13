USE [HHS_Staging]
GO

IF OBJECT_ID('DCFS.Persons', 'U') IS NOT NULL 
  DROP TABLE DCFS.Persons; 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[DCFS].[Persons]') AND name = N'IX_DCFS_DUPLICATES')
DROP INDEX [IX_DCFS_DUPLICATES] ON [DCFS].[Persons] WITH ( ONLINE = OFF )
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[DCFS].[Persons]') AND name = N'IX_DCFS_VALIDATE')
DROP INDEX [IX_DCFS_VALIDATE] ON [DCFS].[Persons] WITH ( ONLINE = OFF )
GO

CREATE TABLE [DCFS].[Persons](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SysInsertDate] [datetime] NOT NULL,
	
	[SocSecNo] [char](9) NULL,
	[SacwisID] CHAR(12) NULL,
	[LastName] [varchar](15) NULL,
	[FirstName] [varchar](15) NULL,
	[MI] [char](1) NULL,
	[BirthDate] [date] NULL,
	
	[HomePhone] varchar(10) NULL,
	[ResAddrLine1] [varchar](45) NULL,
	[ResAddrLine2] [varchar](45) NULL,
	[ResAddrLine3] [varchar] (45) NULL,
	[ResAddrCity] [VARCHAR] (15) NULL,
	[ResAddrCleansedCity] [varchar] (24) NULL,
	[ResAddrState] [char](2) NULL,
	[ResAddrZipCode] char(5) NULL,
	[ResAddrCleansedZipCode] CHAR(5) NULL,
	[ResAddrPlus4] char(4) NULL,
	[ResAddrZipPlus4] AS [ResAddrZipCode] + [ResAddrPlus4] PERSISTED,

	[ProgramName] [varchar](255) DEFAULT ('Unknown'),
	[ServiceType] [varchar](255) DEFAULT ('Unknown'),
	[ServiceDescription] [varchar](255) NOT NULL DEFAULT ('Unknown'),
	[DataSource] [varchar](15) DEFAULT 'SACWIS',
	
	[IsValid] [bit] NOT NULL DEFAULT ((1)),
	[IsCleansed] [bit] NOT NULL DEFAULT ((0)),
	[IsDuplicate] [bit] NOT NULL DEFAULT((0)),
	[IsLoaded] [bit] NOT NULL DEFAULT ((0)),
	[Comments] [varchar](255) NULL,
 CONSTRAINT [PK_DCFS_Persons] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON),
 INDEX [IX_DCFS_DUPLICATES] NONCLUSTERED (SocSecNo, BirthDate)
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

CREATE NONCLUSTERED INDEX [IX_DCFS_VALIDATE] ON [DCFS].[Persons] ([IsValid]) INCLUDE([ID], SocSecNo, LastName, FirstName, MI, BirthDate,ResAddrZipCode);
GO