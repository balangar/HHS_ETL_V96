CREATE TABLE [dbo].[Users]
(
	[UserKey] INT IDENTITY(1,1) NOT NULL,
	[SysInsertUser] VARCHAR(50) NOT NULL DEFAULT 'Sys_ETL',
	[SysInsertDate] DATETIME NOT NULL DEFAULT getdate(),
	[HashSignature]  AS (hashbytes('SHA1',(((((((((((((isnull([ID],'')+isnull([CreatedByID],''))+CONVERT([varchar],isnull([CreatedDate],'1900-01-01'),(121)))+isnull([LastModifiedById],''))+CONVERT([varchar],isnull([SystemModstamp],'1900-01-01'),(121)))+isnull([AccountID],''))+isnull([ContactID],''))+isnull([UserName],''))+isnull([FirstName],''))+isnull([LastName],''))+isnull([Name],''))+isnull([EMail],''))+isnull([Phone],''))+isnull([ManagerID],''))+isnull([SupervisorID],''))),


	[ID] CHAR(18) NOT NULL,
	[CreatedByID] CHAR(18) NULL,
	[CreatedDate] DATE NOT NULL,
	[LastModifiedById] CHAR(18) NOT NULL,
	[LastModifiedDate] DATE NOT NULL,
	[SystemModstamp] DATETIME NOT NULL,

	[AccountID]        CHAR (18)   NULL,
    [ContactID]        CHAR (18)   NULL,

    [UserName]         VARCHAR (80)   NOT NULL,
    [FirstName]        VARCHAR (40)   NULL,
    [LastName]         VARCHAR (80)   NOT NULL,
    [Name]             VARCHAR (128)  NOT NULL,
    [EMail]            VARCHAR (128)  NOT NULL,
    [Phone]            VARCHAR (40)   NULL,

	[ManagerID] CHAR(18) NULL,
	[SupervisorID] CHAR(18) NULL,

	CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([UserKey] ASC)
)
