CREATE TABLE [dbo].[Users] (
    [UserKey]          INT           IDENTITY (1, 1) NOT NULL,
    [SysInsertUser]    VARCHAR (50)  DEFAULT ('Sys_ETL') NOT NULL,
    [SysInsertDate]    DATETIME      DEFAULT (getdate()) NOT NULL,
    [ID]               CHAR (18)     NOT NULL,
    [CreatedByID]      CHAR (18)     NULL,
    [CreatedDate]      DATE          NOT NULL,
    [LastModifiedById] CHAR (18)     NOT NULL,
    [LastModifiedDate] DATE          NOT NULL,
    [SystemModstamp]   DATETIME      NOT NULL,
    [AccountID]        CHAR (18)     NULL,
    [ContactID]        CHAR (18)     NULL,
    [ManagerID]        CHAR (18)     NULL,
    [SupervisorID]     CHAR (18)     NULL,
    [UserName]         VARCHAR (80)  NOT NULL,
    [FirstName]        VARCHAR (40)  NULL,
    [LastName]         VARCHAR (80)  NOT NULL,
    [Name]             VARCHAR (128) NOT NULL,
    [EMail]            VARCHAR (128) NOT NULL,
    [Phone]            VARCHAR (40)  NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([UserKey] ASC)
);


