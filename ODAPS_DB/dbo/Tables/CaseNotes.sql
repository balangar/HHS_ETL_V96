CREATE TABLE [dbo].[CaseNotes]
(
	[CaseNoteKey] INT IDENTITY(1,1) NOT NULL,
	[SysInsertUser] VARCHAR(50) NOT NULL DEFAULT 'System',
	[SysInsertDate] DATETIME NOT NULL DEFAULT getdate(),
	
	[FK_APSCaseNumber] CHAR(18)  NULL,

	[CreatedByID] CHAR(18) NULL,
	[CreatedDate] DATE NULL,
	[LastModifiedById] CHAR(18) NULL,
	[LastModifiedDate] DATE NULL,
	[SystemModstamp] DATETIME NULL,

	[IsClientInterview] BIT NULL,


	[CaseNotesName] VARCHAR(80) NULL,
	[CaseNoteInterviewDate] DATE NULL,
	[ClientInterviewOutsidePerpPresence] VARCHAR(255) NULL,

	[ClientName] VARCHAR(256) NULL,

	[ContactIsTimely] VARCHAR(3) NULL,
	[DaysSinceLastAssessment] INT NULL,
	[ExplainWhyPerpsAttended] VARCHAR(500) NULL,
	[InterviewConductedWith] CHAR(18) NULL,
	[NonParticipatingContact] VARCHAR(100) NULL,

	[NoteType] VARCHAR(255) NULL,
	[Note] VARCHAR(MAX) NULL,

	CONSTRAINT [PK_CaseNotes] PRIMARY KEY CLUSTERED ([CaseNoteKey] ASC)
)
