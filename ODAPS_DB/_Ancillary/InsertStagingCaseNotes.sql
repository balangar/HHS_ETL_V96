/*
INSERT INTO DSAS_ODAPS.dbo.CaseNotes(
	CreatedByID, CreatedDate, LastModifiedByID, LastModifiedDate, SystemModStamp,
	IsClientInterview, APSCaseNumber_REF, 
	CaseNotesName, CaseNoteInterviewDate, ClientName, ContactIsTimely,
	DaysSinceLastAssessment, ExplainWhyPerpsAttended,
	InterviewConductedWith, NonParticipatingContact,
	NoteType, Note)
SELECT
	CreatedByID, CreatedDate, LastModifiedByID, LastModifiedDate, SystemModStamp,
	IsClientInterview, APSCaseNumber_REF, 
	CaseNotesName, CaseNoteInterviewDate, ClientName, ContactIsTimely,
	DaysSinceLastAssessment, ExplainWhyPerpsAttended,
	InterviewConductedWith, NonParticipatingContact,
	NoteType, Note
FROM
	DSAS_ODAPS.temp.CaseNotes	
*/	 
