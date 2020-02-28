CREATE TABLE [dbo].[OBWP - Jail Match] (
    [_ID_]                           INT           NOT NULL,
    [_Residence_County_Code_]        VARCHAR (50)  NOT NULL,
    [_Social_Security_Number_]       VARCHAR (50)  NOT NULL,
    [_Applicant_Status_Code_]        VARCHAR (50)  NOT NULL,
    [_First_Name_]                   VARCHAR (50)  NULL,
    [_Last_Name_]                    VARCHAR (50)  NULL,
    [_Gender_Code_]                  VARCHAR (50)  NOT NULL,
    [_Date_of_Birth_Date_]           DATE          NOT NULL,
    [_Age_]                          FLOAT (53)    NOT NULL,
    [_Case_Serial_Number_]           VARCHAR (50)  NOT NULL,
    [_Program_Code_]                 VARCHAR (50)  NOT NULL,
    [_Caseworker_Number_]            VARCHAR (50)  NOT NULL,
    [_BDA_Aid_Begin_Date_]           DATETIME2 (7) NOT NULL,
    [_Aid_Code_End_Date_]            DATETIME2 (7) NOT NULL,
    [_Applicant_ID_]                 VARCHAR (50)  NOT NULL,
    [_Billing_Number_]               VARCHAR (50)  NULL,
    [_Living_Arrangement_Type_Code_] VARCHAR (50)  NULL
);

