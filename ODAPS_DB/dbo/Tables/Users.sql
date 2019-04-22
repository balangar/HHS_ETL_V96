CREATE TABLE [dbo].[Users]
(
	[UserKey] INT IDENTITY(1,1) NOT NULL,
	[UserID] VARCHAR(18) NOT NULL,

	[SysInsertUser] VARCHAR(50) NOT NULL DEFAULT 'System',
	[SysInsertDate] DATETIME NOT NULL DEFAULT getdate(),
	
	[CreatedByID] CHAR(18) NULL,
	[CreatedDate] DATE NULL,
	[LastModifiedById] CHAR(18) NULL,
	[LastModifiedDate] DATE NULL,
	[SystemModstamp] DATETIME NULL,

	[SupervisorID] VARCHAR(18) NULL,

	[LastName] VARCHAR(80) NULL,
	[FirstName] VARCHAR(40) NULL,
	[Name] VARCHAR(128) NULL,


	CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([UserKey] ASC)

)
