/*
INSERT INTO dbo.Cases(
	CreatedByID, CreatedDate, LastModifiedByID, LastModifiedDate, SystemModstamp,
	CaseID, FK_ReviewedByAPTeam, FK_Supervisor)
SELECT
	CreatedByID, CreatedDate, LastModifiedByID, LastModifiedDate, SystemModstamp,
	CaseID, ReviewedByAPTeam_REF, Supervisor_REF
FROM
	staging.Cases
*/	
