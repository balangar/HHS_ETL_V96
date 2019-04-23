CREATE TABLE [dbo].[Cases]
(
	[CaseKey] INT IDENTITY(1,1) NOT NULL,
	[SysInsertUser] VARCHAR(50) NOT NULL DEFAULT 'System',
	[SysInsertDate] DATETIME NOT NULL DEFAULT getdate(),

	[CreatedByID] CHAR(18) NULL,
	[CreatedDate] DATE NULL,
	[LastModifiedByID] CHAR(18) NULL,
	[LastModifiedDate] DATE NULL,
	[SystemModstamp] DATETIME NULL,

	[CaseID] VARCHAR(18) NOT NULL,

	[FK_ReviewedByAPTeam] VARCHAR(18) NULL,
	[FK_Supervisor] VARCHAR(18) NULL,

	CONSTRAINT [PK_Cases] PRIMARY KEY CLUSTERED ([CaseKey] ASC)

)