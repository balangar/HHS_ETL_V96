/*
INSERT INTO DSAS_ODAPS.dbo.Contacts(
	[ContactID]
      ,[LastName]
      ,[FirstName]
      ,[Name]
      ,[Salutation]
      ,[Alias]
      ,[ApproxAge]
      ,[BirthDate]
	  ,[SocSecNo]
      ,[Medicaid]
      ,[Medicare]
      ,[OfCases]
      ,[OfIntakes]
      ,[MaritalStatus]
      ,[Gender]
      ,[Race]
      ,[Ethnicity]
      ,[PrimaryLanguage]
      ,[OtherCommunicationNeeds]
      ,[TranslatorNeededOtherCommNeeds]
      ,[MailingStreet]
      ,[MailingCity]
      ,[MailingState]
      ,[MailingStateCode]
      ,[MailingCountryCode]
      ,[MailingCountry]
      ,[MailingPostalCode]
      ,[OtherStreet]
      ,[OtherMailingCity]
      ,[OtherMailingState]
      ,[OtherMailingStateCode]
      ,[OtherMailingCountry]
      ,[OtherMailingCountryCode]
      ,[OtherMailingPostalCode]
      ,[SecuritySystemCameras]
      ,[HomePhone]
      ,[MobilePhone]
      ,[WorkExt]
      ,[BestTimeToReach]
      ,[Email]
      ,[IncomeSource]
      ,[HealthInsurance]
      ,[County]
      ,[CountyHeld]
      ,[Department]
      ,[DateAssignedToCounty]
      ,[CourtReportCompletedDate]
      ,[CourtReportDueDate]
      ,[TypeOfAuthority]
      ,[Agency]
      ,[Fax]
      ,[DNR]
      ,[LivingWill]
      ,[OrganDonor]
      ,[ProfessionalSupport]
      ,[MajorMentalIllnessOrEmotionalDisorder]
      ,[UntreatedMentalIllness]
      ,[PhysicalImpairment]
      ,[DevelopmentalOrIntellectualDisability]
      ,[HoardingOrAnimalHoarding]
      ,[NeurologicalImpairmentStrokeOrTBIOrMS]
      ,[MedicalyFragile]
      ,[FrailElderly]
      ,[IsTheClientAtRisk]
      ,[UnknownAtRiskPopulation]
      ,[SpecifyIllegalActivity]
      ,[SpecifyOtherAtRiskActivity]
      ,[ConditionRequiringTotalPhysicalcare]
      ,[DementiaOrAlzheimers]
      ,[PoliceFrequentlyCalledToHome]
      ,[KnownCriminalActivityHistory]
      ,[KnownGangActivity]
      ,[KnownIllegalActivity]
      ,[IllegalDrugUse]
      ,[SubstanceAbuseIncludingPrescriptionMeds]
      ,[InappropriateSexualBehaviors]
      ,[PerpLivesWithClient]
      ,[PerpetratorAge]
      ,[FamilyOrOtherSupport]
      ,[ClientLivesWith]
      ,[KinshipCode]
      ,[ClientsHome]
      ,[DangerousHomeStructure]
      ,[GatedLockedCommunityBuilding]
      ,[SpecifyFacilityType]
      ,[TypeOfFacility]
      ,[SafetyWarning]
      ,[SafetyNotes]
      ,[AreThereAnySafetyWarningsForCaseWorkers]
      ,[WorkerSafetyIssue]
      ,[WorkerSafetyConcerns]
      ,[AtRiskPopulationCheckbox]
      ,[UnsafeNeighborhood]
      ,[Biohazard]
      ,[ContagiousDisease]
      ,[BugOrVerminInfestation]
      ,[DangerousOrAggressiveAnimals]
      ,[DangerousOrAggressivePersonInHome]
      ,[BurialOrCremation]
      ,[AdditionalEndOfLifeInformation]
      ,[CreatedById]
      ,[CreatedDate]
      ,[LastModifiedById]
      ,[LastModifiedDate]
      ,[SystemModstamp]
)

SELECT 
	[ContactID]
      ,[LastName]
      ,[FirstName]
      ,[Name]
      ,[Salutation]
      ,[Alias]
      ,[ApproxAge]
      ,[BirthDate]
      ,[SSN]
      ,[Medicaid]
      ,[Medicare]
      ,[OfCases]
      ,[OfIntakes]
      ,[MaritalStatus]
      ,[Gender]
      ,[Race]
      ,[Ethnicity]
      ,[PrimaryLanguage]
      ,[OtherCommunicationNeeds]
      ,[TranslatorNeededOtherCommNeeds]
      ,[MailingStreet]
      ,[MailingCity]
      ,[MailingState]
      ,[MailingStateCode]
      ,[MailingCountryCode]
      ,[MailingCountry]
      ,[MailingPostalCode]
      ,[OtherStreet]
      ,[OtherMailingCity]
      ,[OtherMailingState]
      ,[OtheMailingStateCode]
      ,[OtherMailingCountry]
      ,[OtherMailingCountryCode]
      ,[OtherMailingPostalCode]
      ,[SecuritySystemCameras]
      ,[HomePhone]
      ,[MobilePhone]
      ,[WorkExt]
      ,[BestTimeToReach]
      ,[Email]
      ,[IncomeSource]
      ,[HealthInsurance]
      ,[County]
      ,[CountyHeld]
      ,[Department]
      ,[DateAssignedToCounty]
      ,[CourtReportCompletedDate]
      ,[CourtReportDueDate]
      ,[TypeOfAuthority]
      ,[Agency]
      ,[Fax]
      ,[DNR]
      ,[LivingWill]
      ,[OrganDonor]
      ,[ProfessionalSupport]
      ,[MajorMentalIllnessOrEmotionalDisorder]
      ,[UntreatedMentalIllness]
      ,[PhysicalImpairment]
      ,[DevelopmentalOrIntellectualDisability]
      ,[HoardingOrAnimalHoarding]
      ,[NeurologicalImpairmentStrokeOrTBIOrMS]
      ,[MedicalyFragile]
      ,[FrailElderly]
      ,[IsTheClientAtRisk]
      ,[UnknownAtRiskPopulation]
      ,[SpecifyIllegalActivity]
      ,[SpecifyOtherAtRiskActivity]
      ,[ConditionRequiringTotalPhysicalcare]
      ,[DementialOrAlzheimers]
      ,[PoliceFrequentlyCalledToHome]
      ,[KnownCriminalActivityHistory]
      ,[KnownGangActivity]
      ,[KnownIllegalActivity]
      ,[IllegalDrugUse]
      ,[SubstanceAbuseIncludingPrescriptionMeds]
      ,[InappropriateSexualBehaviors]
      ,[PerpLivesWithClient]
      ,[PerpetratorAge]
      ,[FamilyOrOtherSupport]
      ,[ClientLivesWith]
      ,[KinshipCode]
      ,[ClientsHome]
      ,[DangerousHomeStructure]
      ,[GatedLockedCommunityBuilding]
      ,[SpecifyFacilityType]
      ,[TypeOfFacility]
      ,[SafetyWarning]
      ,[SafetyNotes]
      ,[AreThereAnySafetyWarningsForCaseWorkers]
      ,[WorkerSafetyIssue]
      ,[WorkerSafetyConcerns]
      ,[AtRiskPopulationCheckbox]
      ,[UnsafeNeighborhood]
      ,[Biohazard]
      ,[ContagiousDisease]
      ,[BugOrVerminInfestation]
      ,[DangerousOrAggressiveAnimals]
      ,[DangerousOrAggressivePersonInHome]
      ,[BurialOrCremation]
      ,[AdditionalEndOfLifeInformation]
      ,[CreatedById]
      ,[CreatedDate]
      ,[LastModifiedById]
      ,[LastModifiedDate]
      ,[SystemModstamp]
  FROM [DSAS_ODAPS].[temp].Contacts]
*/