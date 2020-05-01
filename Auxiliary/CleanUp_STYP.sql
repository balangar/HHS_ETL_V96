--USE OCSS_SCAS
--GO


--Select * from dbo.STYP

--ALTER TABLE dbo.STYP
--	ADD 
--		ID INTEGER IDENTITY(1,1) NOT NULL PRIMARY KEY,
--		SysInsertUser	VARCHAR(50) NOT NULL DEFAULT 'SYSTEM',
--		SysinsertDate	datetime	NOT NULL DEFAULT getdate()

--ALTER TABLE dbo.STYP
--	DROP COLUMN FIELD1

--exec sp_rename 'dbo.STYP.Field3', 'CaseKey', 'COLUMN';	-- Safe because nothing else references ... yet. [geg] 2020-04-30
--exec sp_rename 'dbo.STYP.Field5', 'CaseCloseDate', 'COLUMN';	-- Safe because nothing else references ... yet. [geg] 2020-04-30
--exec sp_rename 'dbo.STYP.Field7', 'CaseOpenDate_Text', 'COLUMN';	-- Safe because nothing else references ... yet. [geg] 2020-04-30
--exec sp_rename 'dbo.STYP.Field9', 'CaseTypeCode', 'COLUMN';	-- Safe because nothing else references ... yet. [geg] 2020-04-30
--exec sp_rename 'dbo.STYP.Field11', 'CaseStatusCode', 'COLUMN';	-- Safe because nothing else references ... yet. [geg] 2020-04-30
--exec sp_rename 'dbo.STYP.CaseCloseDate', 'CaseCloseDate_Text', 'COLUMN'  		-- Safe because nothing else referenes ... yet.  [geg]


--ALTER TABLE dbo.STYP
--	ADD
--		CaseOpenDate DATE NULL,
--		CaseType VARCHAR(7) NOT NULL DEFAULT 'Unknown',
--		CaseStatus VARCHAR (7) NOT NULL DEFAULT 'Unknown',
--		CaseCloseDate DATE NULL

--UPDATE dbo.STYP
--	SET
--		CaseCloseDate = TRY_CAST(CaseCloseDate_Text As DATE)

--Select * from dbo.STYP Where CaseCloseDate IS NULL

--UPDATE dbo.STYP	
--	SET
--		CaseOpenDate = TRY_CAST(CaseOpenDate_Text  As DATE)

--Select * from dbo.STYP Where CaseopenDate  IS NULL

--UPDATE dbo.STYP
--	SET
--		CaseType =
--			CASE
--				WHEN CaseTypeCode = 'A' THEN 'PA'
--				WHEN CaseTypeCode = 'B' THEN 'PA-NPA'
--				WHEN CaseTypeCode = 'C' THEN 'PA-NON4D'
--				WHEN CaseTypeCode = 'F' THEN 'NPA-SS' 
--				WHEN CaseTypeCode = 'G' THEN '4E'
--				WHEN CaseTypeCode = 'H' THEN '4E-NPA'
--				WHEN CaseTypeCode = 'I' THEN '4E-NPA-SS'
--				WHEN CaseTypeCode = 'J' THEN '4E-NON-4D'
--				WHEN CaseTypeCode = 'K' THEN 'AFDC-4E'
--				WHEN CaseTypeCode = 'L' THEN 'AFDC-4E-NPA'
--				WHEN CaseTypeCode = 'M' THEN 'AFDC-4E-NPA-SS'
--				WHEN CaseTypeCode = 'N' THEN 'NPA'
--				WHEN CaseTypeCode = 'O' THEN 'AFDC-NPA-SS'
--				WHEN CaseTypeCode = 'X' THEN 'NON4D'
--				ELSE 'Unknown'
--			END

--SELECT Distinct CaseType from dbo.STYP

--Select * from dbo.Styp Where CaseType = 'Unknown'

--UPDATE dbo.STYP
--	SET
--		CaseStatus =
--			CASE
--				WHEN CaseStatusCode = 'C' Then 'Closed'
--				WHEN CaseStatusCode = 'A' THEN 'Active'
--				ELSE 'Unknown'
--			END

