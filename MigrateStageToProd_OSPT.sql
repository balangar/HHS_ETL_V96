FOO!	-- so I don't accidentally execute the whole thing at once. [geg]

--Drop Table Staging.OSPT
--Drop Table dbo.OSPT
--Select * from Staging.OSPT

--Select * into dbo.OSPT From Staging.OSPT

Select * from dbo.OSPT  

--ALTER TABLE dbo.OSPT	ALTER COLUMN	ArchiveType			char(4)		NOT NULL;
--ALTER TABLE dbo.OSPT	ALTER COLUMN	OrderNumber			char(16)	NOT NULL;
--ALTER TABLE dbo.OSPT	ALTER COLUMN	CustodialParentID	char(9)		NOT NULL;
--ALTER TABLE dbo.OSPT	ALTER COLUMN	AbsentParentID		char(9)		NOT NULL;

--ALTER TABLE dbo.OSPT	ADD CaseKey As LTRIM(RTRIM(CustodialParentID)) + LTRIM(RTRIM(AbsentParentID)) PERSISTED;


--CREATE NONCLUSTERED INDEX OrderNumber_Incl
--ON dbo.OSPT(OrderNumber)
--INCLUDE(CaseKey);

--Create NONCLUSTERED INDEX CaseKey_Incl
--ON dbo.OSPT(CaseKey)
--INCLUDE(OrderNumber);