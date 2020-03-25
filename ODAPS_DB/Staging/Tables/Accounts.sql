CREATE TABLE [Staging].[Accounts] (
    [AccountKey]            INT            IDENTITY (1, 1) NOT NULL PRIMARY KEY,
    [SysInsertUser]         VARCHAR (50)   DEFAULT ('System') NOT NULL,
    [SysInsertDate]         DATETIME       DEFAULT (getdate()) NOT NULL,
    [HashSignature]         AS      HASHBYTES('SHA1',
                                            IsNull(ID, '') +
                                            IsNull(CreatedByID, '') +
                                            Convert(varchar, ISNull(CreatedDate, '1900-01-01')) +
                                            ISNULL(LastModifiedById, '') +
                                            CONVERT(VARCHAR, ISNULL(LastModifiedDate, '1900-01-01')) +
                                            CONVERT(VARCHAR, ISNULL(SystemModstamp, '')) +
                                            CONVERT(VARCHAR, ISNULL(IsDeleted, 0)) +

                                            ISNULL(MasterRecordID, '') +
                                            ISNULL(OwnerID, '') +
                                            ISNULL(ParentID, '') +
                                            ISNULL(RecordTypeID, '') +
                                            ISNULL(Type, '') +
                                            ISNULL(NAME, '') +
                                            ISNULL(Description, '') +
                                            CONVERT(VARCHAR, ISNULL(LastActivityDate, '')) +
                                            CONVERT(VARCHAR, ISNULL(LastViewedDate, '')) +
                                            CONVERT(VARCHAR, ISNULL([LastReferencedDate], ''))                                             
                                        ),
	
    [ID]                 VARCHAR (18)   NULL,
    [CreatedByID]        CHAR (18)      NULL,
    [CreatedDate]        VARCHAR (50)   NULL,
    [LastModifiedById]   CHAR (18)      NULL,
    [LastModifiedDate]   VARCHAR (50)   NULL,
    [SystemModstamp]     VARCHAR (50)   NULL,
    [IsDeleted]          BIT            NULL,
	
    [MasterRecordID]     VARCHAR (18)   NULL,
    [OwnerID]            VARCHAR (18)   NULL,
    [ParentID]           VARCHAR (18)   NULL,
    [RecordTypeID]       VARCHAR (18)   NULL,
    [Type]               VARCHAR (40)   NULL,
    [Name]               VARCHAR (255)  NULL,
    [Description]        VARCHAR (4096) NULL,
    [LastActivityDate]   VARCHAR (50)   NULL,
    [LastViewedDate]     VARCHAR (50)   NULL,
    [LastReferencedDate] VARCHAR (50)   NULL,
	
    [IsValid]            BIT            NOT NULL DEFAULT 1,
    [IsLoaded]           BIT            NOT NULL DEFAULT 0,
    [LoadDate]           DATETIME       NOT NULL DEFAULT '1900-01-01',
    [Comments]           VARCHAR (1024) NULL
);





