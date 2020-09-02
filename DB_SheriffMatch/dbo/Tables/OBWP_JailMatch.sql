CREATE TABLE dbo.[OBWP_JailMatch] (
    [ID]                        INT              IDENTITY (1, 1) NOT NULL PRIMARY KEY,
    [SysInsertUser]             VARCHAR (50)     DEFAULT ('System') NOT NULL,
    [SysInsertDate]             DATETIME         DEFAULT (getdate()) NOT NULL,
	[SysModifyUser]				VARCHAR(50)		 DEFAULT ('System') NOT NULL,
	[SysModifyDate]				DATETIME		 DEFAULT (getdate()) NOT NULL,
    [HashSignature]             VARBINARY (8000) NULL,
    [ResidenceCountyCode]       CHAR (2)         NULL,
    [SocSecNo]                  CHAR (9)         NULL,
    [ApplicantStatusCode]       VARCHAR (50)     NULL,
    [FirstName]                 VARCHAR (50)     NULL,
    [LastName]                  VARCHAR (50)     NULL,
    [GenderCode]                VARCHAR (50)     NULL,
    [BirthDate]                 DATE             NULL,
    [Age]                       INT              NULL,
    [CaseSerialNumber]          VARCHAR (50)     NULL,
    [ProgramCode]               VARCHAR (50)     NULL,
    [CaseWorkerNumber]          VARCHAR (50)     NULL,
    [BDAAidBeginDate]           DATE             NULL,
    [AidCodeEndDate]            DATE             NULL,
    [ApplicantID]               VARCHAR (50)     NULL,
    [BillingNumber]             VARCHAR (50)     NULL,
    [LivingArrangementTypeCode] VARCHAR (50)     NULL
);



