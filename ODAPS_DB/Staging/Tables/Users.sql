CREATE TABLE [Staging].[Users] (
    [UserKey]          INT            IDENTITY (1, 1) NOT NULL PRIMARY KEY,
    [SysInsertUser]    VARCHAR (50)   DEFAULT ('System') NOT NULL,
    [SysInsertDate]    DATETIME       DEFAULT (getdate()) NOT NULL,
    [HashSignature]    AS
                            Hashbytes
                                (
                                    'SHA1',
                                    ISNULL(ID, '') +
                                    ISNULL(CreatedByID, '') +
                                    CONVERT(VARCHAR, ISNull(CreatedDate, '1900-01-01')) +
 									ISNULL([LastModifiedById], '') +
                                    CONVERT(VARCHAR, ISNULL(LastModifiedDate, '1900-01-01')) +
                                    CONVERT(VARCHAR, ISNULL(SystemModStamp, '1900-01-01')) +

									ISNULL([AccountID], '') +
									ISNULL([ContactID], '') +

									ISNULL([UserName], '') +
									ISNULL([FirstName], '') +
									ISNULL([LastName], '') +
									ISNULL([Name], '') +
									ISNULL([EMail], '') +
									ISNULL([Phone], '') +

									ISNULL([ManagerID], '') +
									ISNULL([Supervisor__c], '')                                   
                                ),

    [ID]               VARCHAR (18)   NULL,
    [CreatedByID]      CHAR (18)      NULL,
    [CreatedDate]      DATE   NULL,
    [LastModifiedById] CHAR (18)      NULL,
    [LastModifiedDate] DATE			  NULL,
    [SystemModstamp]   DATETIME		  NULL,

    [AccountID]        VARCHAR (18)   NULL,
    [ContactID]        VARCHAR (18)   NULL,

    [UserName]         VARCHAR (80)   NULL,
    [FirstName]        VARCHAR (40)   NULL,
    [LastName]         VARCHAR (80)   NULL,
    [Name]             VARCHAR (128)  NULL,
    [EMail]            VARCHAR (128)  NULL,
    [Phone]            VARCHAR (40)   NULL,

    [ManagerID]        VARCHAR (18)   NULL,
    [Supervisor__c]    VARCHAR (18)   NULL,
	
    [IsValid]          BIT            NOT NULL DEFAULT 1,
    [IsLoaded]         BIT            NOT NULL DEFAULT 0,
    [LoadDate]         DATETIME       NOT NULL DEFAULT '1900-01-01',

    [Comments]         VARCHAR (1024) NULL
);




