
USE [HHS_Staging]
GO

IF OBJECT_ID('JFS.CRISE', 'U') IS NOT NULL 
  DROP TABLE JFS.CRISE; 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[JFS].[CRISE]') AND name = N'IX_CRISE_DUPLICATES')
DROP INDEX [IX_CRISE_DUPLICATES] ON [JFS].[CRISE] WITH ( ONLINE = OFF )
GO
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[JFS].[CRISE]') AND name = N'IX_CRISE_VALIDATE')
DROP INDEX [IX_CRISE_VALIDATE] ON [JFS].[CRISE] WITH ( ONLINE = OFF )
GO
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[JFS].[CRISE]') AND name = N'IX_CRISE_ExtractPopulation')
DROP INDEX [IX_CRISE_ExtractPopulation] ON [JFS].[CRISE] WITH ( ONLINE = OFF )
GO

CREATE TABLE [JFS].[CRISE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SysInsertDate] [datetime] DEFAULT (getdate()),
	[Signature] AS 
		HASHBYTES('MD5', IsNull(SocSecNo,'') + IsNull(RecipientNo,'') + IsNull(LastName,'') + IsNull(FirstName,'') + IsNull(MI,'') + 
				   ISNULL(TRY_CONVERT(varchar(10), BirthDate, 111),'') +
				   ISNULL(ResAddrLine1,'') + ISNULL(ResAddrLine2,'') + 
				   ISNULL(ResAddrCity,'') + ISNULL(ResAddrState,'') + IsNull(ResAddrZipCode,'') +
				   ISNULL(ResAddrCleansedCity,'') + IsNull(ResAddrCleansedZipCode,'')) PERSISTED,
	[SocSecNo] [char](9) NULL,
	[RecipientNo] char(12) NOT NULL,
	[LastName] [varchar](15) NULL,
	[FirstName] [varchar](15) NULL,
	[MI] [char](1) NULL,
	[BirthDate] [date] NULL,
	[Age] AS (datediff(hour,BirthDate,getdate())/(8766)),
	[HomePhone] varchar(10) NULL,
	[ResAddrLine1] [varchar](45) NULL,
	[ResAddrLine2] [varchar](45) NULL,
	[ResAddrLine3] [varchar] (45)NULL,
	[ResAddrCity] [varchar](24) NULL,
	[ResAddrCleansedCity] [VARCHAR](24) NULL,
	[ResAddrState] [char](2) NULL,
	[ResAddrZipCode] char(5) NULL,
	[ResAddrCleansedZipCode] CHAR(5) NULL,
	[ResAddrPlus4] char(4) NULL,
	[ResAddrZipPlus4] AS [ResAddrZipCode] + [ResAddrPlus4] PERSISTED,
	[ProgramName] [varchar](7) DEFAULT ('Unknown'),
	[ServiceType] [varchar](7) DEFAULT ('Unknown'),
	[ServiceDescription] [varchar](255) DEFAULT ('Unknown'),
	[DataSource] [varchar](15) DEFAULT ('CRISE'),
	[InCounty] BIT NOT NULL DEFAULT  0,
	[InState] AS CASE WHEN ResAddrState = 'OH' THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END PERSISTED,
	[IsValid] [bit] NOT NULL DEFAULT ((1)),
	[IsCleansed] [bit] NOT NULL DEFAULT ((0)),
	[IsDuplicate] [bit] NOT NULL DEFAULT((0)),
	[IsLoaded] [bit] NOT NULL DEFAULT ((0)),
	[Comments] [varchar](255) NULL,
 CONSTRAINT [PK_JFS_CRISE] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 INDEX [IX_CRISE_DUPLICATES] NONCLUSTERED (SocSecNo, BirthDate)
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

CREATE NONCLUSTERED INDEX [IX_CRISE_VALIDATE] ON [JFS].[CRISE] ([IsValid]) INCLUDE([ID], SocSecNo, LastName, FirstName, MI, BirthDate,ResAddrZipCode);
CREATE NONCLUSTERED INDEX [IX_CRISE_ExtractPopulation] ON [JFS].[CRISE] (IsValid, IsCleansed, IsDuplicate);
GO



