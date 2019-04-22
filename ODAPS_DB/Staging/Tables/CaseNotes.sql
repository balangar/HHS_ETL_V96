CREATE TABLE [Staging].[CaseNotes](
	[CaseNoteKey] [int] IDENTITY(1,1) NOT NULL,

	[SysInsertUser] [varchar](50) NOT NULL DEFAULT 'System',
	[SysInsertDate] [datetime] NOT NULL DEFAULT getdate(),
	[CreatedByID] [char](18) NULL,
	[CreatedDate] [date] NULL,
	[LastModifiedById] [char](18) NULL,
	[LastModifiedDate] [date] NULL,
	[SystemModstamp] [datetime] NULL,
	[IsClientInterview] [bit] NULL,
	[APSCaseNumber_REF] [char](18) NULL,
	[CaseNotesName] [varchar](80) NULL,
	[CaseNoteInterviewDate] [date] NULL,
	[ClientInterviewOutsidePerpPresence] [varchar](255) NULL,
	[ClientName] [varchar](256) NULL,
	[ContactIsTimely] [varchar](3) NULL,
	[DaysSinceLastAssessment] [int] NULL,
	[ExplainWhyPerpsAttended] [varchar](500) NULL,
	[InterviewConductedWith] [char](18) NULL,
	[NonParticipatingContact] [varchar](100) NULL,
	[NoteType] [varchar](255) NULL,
	[Note] [varchar](max) NULL,

 CONSTRAINT [PK_CaseNotes] PRIMARY KEY CLUSTERED ([CaseNoteKey] ASC)
 );