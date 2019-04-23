CREATE TABLE [Staging].[Contacts]
(
	[ContactKey] INT IDENTITY(1,1) NOT NULL,
	[SysInsertUser] VARCHAR(50) NOT NULL DEFAULT 'System',
	[SysInsertDate] DATETIME NOT NULL DEFAULT getdate(),
	
	[ContactID] VARCHAR(18) NOT NULL,

	[LastName] VARCHAR(80) NULL,
	[FirstName] VARCHAR(40) NULL,
	[Salutation] VARCHAR(10) NULL,
	[Alias] VARCHAR(255) NULL,
	[BirthDate] DATE NULL,
	[ApproxAge] DECIMAL(18,2) NULL,
	[SocSecNo] CHAR(9) NULL,

	[MaritalStatus] VARCHAR(30) NULL,
	[Gender] VARCHAR(30) NULL,
	[Race] VARCHAR(1300) NULL,
	[Ethnicity] VARCHAR(5000) NULL,

	[Medicaid] VARCHAR(255) NULL,
	[Medicare] VARCHAR(255) NULL,
	[OFCases] DECIMAL(18,2) NULL,
	[OfIntakes] DECIMAL(18,2) NULL,

	[PrimaryLanguage] VARCHAR(128),
	[OtherCommunicationNeeds] VARCHAR(50) NULL,
	[TranslatorNeededOtherCommNeeds] VARCHAR(3) NULL,

	[County] VARCHAR(30) NULL,
	[CountyHeld] VARCHAR(30) NULL,
	[DateAssignedToCounty] DATE NULL,
	[Department] VARCHAR(80) NULL,
	[Agency] VARCHAR(50) NULL,
	[TypeOfAuthority] VARCHAR(30) NULL,

	
	[CourtReportDueDate] DATE NULL,
	[CourtReportCompletedDate] DATE NULL,

	[MailingStreet] VARCHAR(255) NULL,
	[MailingCity] VARCHAR(40) NULL,
	[MailingState] VARCHAR(80), 
	[MailingStateCode] VARCHAR(3) NULL,
	[MailingCountry] VARCHAR(80) NULL,
	[MailingCountryCode] CHAR(2) NULL,
	[MailingPostalCode] VARCHAR(20),

	[OtherStreet] VARCHAR(255) NULL,
	[OtherMailingCity] VARCHAR(40) NULL,
	[OtherMailingState] VARCHAR(80), 
	[OtherMailingStateCode] VARCHAR(3) NULL,
	[OtherMailingCountry] VARCHAR(80) NULL,
	[OtherMailingCountryCode] CHAR(2) NULL,
	[OtherMailingPostalCode] VARCHAR(20),

	[HomePhone] VARCHAR(40) NULL,
	[MobilePhone] VARCHAR(40) NULL,
	[WorKExt] VARCHAR(15) NULL,
	[Fax] VARCHAR(40) NULL,
	[BestTimeToReach] VARCHAR(255) NULL,

	[Email] VARCHAR(80) NULL,

	[IncomeSource] VARCHAR(255) NULL,
	[HealthInsurance] VARCHAR(255) NULL,

	[DNR] VARCHAR(7) NULL,
	[LivingWill] VARCHAR(7) NULL,
	[OrganDonor] VARCHAR(7) NULL,

	[IsTheClientAtRisk] VARCHAR(7) NULL,
	[ConditionRequiringTotalPhysicalCare] BIT NULL,
	[MajorMentalIllnessOrEmotionalDisorder] BIT NULL,
	[DementiaOrAlzheimers] BIT NULL,
	[UntreatedMentalIllness] BIT NULL,
	[PhysicalImpairment] BIT NULL,
	[DevelopmentalOrIntellectualDisability] BIT NULL,
	[HoaringOrAnimalHoarding] BIT NULL,
	[NeurologicalImpairmentStrokeOrTBIOrMS] BIT NULL,
	[MedicialyFragile] BIT NULL,
	[FrailElderly] BIT NULL,
	[UnknownAtRiskPopulation] BIT NULL,

	[SpecifyIllegalActivity] VARCHAR(255),
	[PoliceFrequentlyCalledToHome] VARCHAR(7) NULL,
	[KnownCriminalActivityHistory] VARCHAR(7) NULL,
	[KnownIllegalActivity] VARCHAR(7) NULL,
	[KnownGangActivity] VARCHAR(7) NULL,

	[IllegalDrugManufacturing] BIT NULL,
	[IllegalDrugUse] BIT NULL,
	[SubstanceAbuseIncludingPrescriptionMeds] BIT NULL,

	[InappropriateSexualBehaviors] BIT NULL,

	[PerpLivesWithClient] VARCHAR(7) NULL,
	[PerpetratorAge] DECIMAL(18,2) NULL,

	[SpecifyOtherAtRiskActivity] VARCHAR(30),

	[ProfessionalSupport] VARCHAR(MAX) NULL,
	[FamilyOrOtherSupport] VARCHAR(30),
	[ClientLivesWith] VARCHAR(30) NULL,
	[KinshipCode] VARCHAR(30) NULL,

	[SpecifyFacilityType] VARCHAR(30),
	[TypeOfFacility] VARCHAR(64),

	[ClientsHome] VARCHAR(30) NULL,
	[GatedLockedCommunityBuilding] BIT NULL,
	[DangerousHomeStructure] BIT NULL,

	[WorkerSafetyIssue] BIT NULL,
	[WorkerSafetyConcerns] VARCHAR(30) NULL,
	[AreThereAnySafetyWarningsForCaseworkers] VARCHAR(7) NULL,
	[SafetyWarning] VARCHAR(1300) NULL,
	[SafetyNotes] VARCHAR(MAX) NULL,

	[AtRiskPopulationCheckbox] BIT NULL,
	[UnsafeNeighborhood] BIT NULL,
	[BioHazard] BIT NULL,
	[ContagiousDisease] BIT NULL,
	[BugOrVerminInfestation] BIT NULL,
	[DangerousOrAggressiveAnimals] BIT NULL,
	[DangerousOrAggressivePersonInHome] BIT NULL,

	[BurialOrCremation] VARCHAR(10) NULL,
	[AdditionalEndOfLifeInformation] VARCHAR(MAX) NULL,

	[SecuritySystemCameras] BIT NULL,

	[CreatedByID] CHAR(18) NULL,
	[CreatedDate] DATE NULL,
	[LastModifiedByID] CHAR(18) NULL,
	[LastModifiedDate] DATE NULL,
	[SystemModstamp] DATETIME NULL,



	CONSTRAINT [PK_Contacts] PRIMARY KEY CLUSTERED ([ContactKey] ASC)

);