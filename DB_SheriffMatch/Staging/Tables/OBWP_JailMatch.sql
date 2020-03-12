CREATE TABLE [Staging].[OBWP_JailMatch] (
    [ID]                        INT              IDENTITY (1, 1) NOT NULL,
    [SysInsertUser]             VARCHAR (50)     DEFAULT ('System') NOT NULL,
    [SysInsertDate]             DATETIME         DEFAULT (getdate()) NOT NULL,
    [HashSignature]             VARBINARY (8000) NULL,
    [ResidenceCountyCode]       CHAR (2)         NULL,
    [SocSecNo]                  CHAR (9)         NULL,
    [ApplicantStatusCode]       VARCHAR (50)     NULL,
    [FirstName]                 VARCHAR (50)     NULL,
    [LastName]                  VARCHAR (50)     NULL,
    [GenderCode]                VARCHAR (50)     NULL,
    [BirthDate]                 VARCHAR (50)     NULL,
    [Age]                       VARCHAR (50)     NULL,
    [CaseSerialNumber]          VARCHAR (50)     NULL,
    [ProgramCode]               VARCHAR (50)     NULL,
    [CaseWorkerNumber]          VARCHAR (50)     NULL,
    [BDAAidBeginDate]           VARCHAR (50)     NULL,
    [AidCodeEndDate]            VARCHAR (50)     NULL,
    [ApplicantID]               VARCHAR (50)     NULL,
    [BillingNumber]             VARCHAR (50)     NULL,
    [LivingArrangementTypeCode] VARCHAR (50)     NULL,
    [IsValid]                   BIT              DEFAULT ((1)) NOT NULL,
    [IsLoaded]                  BIT              DEFAULT ((0)) NOT NULL,
    [LoadDate]                  DATETIME         DEFAULT ('1900-01-01') NOT NULL,
    [Comments]                  VARCHAR (1024)   NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
);






GO
CREATE NONCLUSTERED INDEX [IX_OBWP_JailMatch_Valid]
    ON [Staging].[OBWP_JailMatch]([IsValid] ASC);

