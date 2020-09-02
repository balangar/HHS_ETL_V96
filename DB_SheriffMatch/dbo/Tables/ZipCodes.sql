CREATE TABLE [dbo].[ZipCodes] (
    [ID]   INT          IDENTITY (1, 1) NOT NULL,
    [Zip]  INT          NULL,
    [City] VARCHAR (50) NULL,
    CONSTRAINT [PK_NFSCZipCodes] PRIMARY KEY CLUSTERED ([ID] ASC)
);

