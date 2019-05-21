CREATE VIEW dbo.View_2
AS
SELECT        TOP (100) PERCENT dbo.Contacts.LastName, dbo.Contacts.FirstName, Staging.Cases.AbleToCareForThemselves, Staging.Cases.AbleToCareForThemselvesInformation, Staging.Cases.ActionsTakenPriorToThisCall, 
                         Staging.Cases.AdditionalNotes, Staging.Cases.AdequateNutritionHydration, Staging.Cases.AdequateSupervision, Staging.Cases.ADLsToiletingBathingHygieneToileting, Staging.Cases.AgenciesAssistingInInvestigation, 
                         Staging.Cases.AllowSomeoneToLiveWithThem, Staging.Cases.AppropriateMedicalTreatment, Staging.Cases.ApprovalKickoff, Staging.Cases.ApprovalStatus, Staging.Cases.ApproximateAge, 
                         Staging.Cases.ApproximatLossOfAssets, Staging.Cases.APTeamReviewDate, Staging.Cases.AreThereExistingConditions, Staging.Cases.AreThereSafetyIssuesForCO, Staging.Cases.ReAssessmentCompletedDate, 
                         Staging.Cases.AssessmentCount, Staging.Cases.AssessmentScoringInfo, Staging.Cases.AuxiliaryDate, Staging.Cases.FirstAssessmentRiskScore, Staging.Cases.FirstAssessmentSafetyScore, 
                         Staging.Cases.BathingAndHygiene, Staging.Cases.BestTimeToReachClient, Staging.Cases.BillsFinances, Staging.Cases.Biohazard, Staging.Cases.PhysicalAbuseBrokenBones, Staging.Cases.SexualAbuseBrokenBones, 
                         Staging.Cases.PhysicalAbuseBruises, Staging.Cases.SexualAbuseBruises, Staging.Cases.BugOrVerminInfestation, Staging.Cases.CaretakerAdditionalDetails, Staging.Cases.CaretakerNeglect, 
                         Staging.Cases.CaretakerNeglectWereThereAnyWitness, Staging.Cases.CaseClosureApprovalStatus, Staging.Cases.CaseClosureCorrectionsCompleted, Staging.Cases.OnGoingClientNeeds, Staging.Cases.CaseDuration, 
                         Staging.Cases.Name, Staging.Cases.CasePlanCompletedDate, Staging.Cases.CasePlanCount, Staging.Cases.CauseHarmOrLoss, Staging.Cases.CauseHarmOrLossInformation, Staging.Cases.CBMSCaseNumber, 
                         Staging.Cases.ClientAddress, Staging.Cases.ClientAllegedPerpetratorHistory, Staging.Cases.ClientAtRiskInfo, Staging.Cases.ClientName, Staging.Cases.ClientsAge, Staging.Cases.ClientsCurrentLocation, 
                         Staging.Cases.CaseClosedReason, Staging.Cases.ComplicatingRisksVulnerabilities, Staging.Cases.ConditionNone, Staging.Cases.ConditionRequiringTotalPhysicalCare, Staging.Cases.ConditionUnabletoManageNone, 
                         Staging.Cases.ConditionUnabletoManageUnknown, Staging.Cases.ConditionUnknown, Staging.Cases.Confidential, Staging.Cases.TemporaryContact, Staging.Cases.ContagiousDisease, Staging.Cases.CountOfAllegations, 
                         Staging.Cases.CaseCounty, Staging.Cases.CountyCalendar, Staging.Cases.CountyHeld, Staging.Cases.CountyTypeOfAuthority, Staging.Cases.CourtReportCompletedDate, Staging.Cases.CourtReportDueDate, 
                         Staging.Cases.CreatedById, Staging.Cases.CreatedDate, Staging.Cases.CriminalInvestigationStatus, Staging.Cases.CulturalConsiderations, Staging.Cases.CurrentStrengthsSupports, Staging.Cases.PhysicalAbuseCuts, 
                         Staging.Cases.SexualAbuseCuts, Staging.Cases.DangerHarm, Staging.Cases.DangerousAggressiveAnimals, Staging.Cases.DangerousHomeStructure, Staging.Cases.DateCaseClosed, Staging.Cases.DateOfBirth, 
                         Staging.Cases.DateOfDeath, Staging.Cases.DaysBetweenAssessments, Staging.Cases.DaysOfInActivity, Staging.Cases.DaysOpen, Staging.Cases.DecisionMakingUnderstandingDeficits, Staging.Cases.DeclineInAbilities, 
                         Staging.Cases.DeclineInAbilitiesInformation, Staging.Cases.IsDeleted, Staging.Cases.DementiaAlzheimers, Staging.Cases.DevelopmentalIntellectualDisability, Staging.Cases.DiagnosedMentalIllness, 
                         Staging.Cases.DiagnosedMentalIllnessInfo, Staging.Cases.DifferenceOfDays, Staging.Cases.DocumentsForLegalAuthority, Staging.Cases.DoesAdultHaveSupportHelpInPlace, 
                         Staging.Cases.DoesAllegedPerpHaveAccessToAdult, Staging.Cases.DoesPerpHoldLegalAuthority, Staging.Cases.DoesPerpLiveWithClient, Staging.Cases.DoesPartyReceiveFundsFromClient, 
                         Staging.Cases.EmergencyImmediateHarm, Staging.Cases.EmergencyImmediateHarmInformation, Staging.Cases.EvidenceOfNeglectExploitationAndA, Staging.Cases.ExplainWhyAdultIsBeingMistreated, 
                         Staging.Cases.Exploitation, Staging.Cases.ExploitationAdditionalDetails, Staging.Cases.FearAsAResultOfAPersonsAction, Staging.Cases.FirearmsOrOtherWeapons, Staging.Cases.ForAnotherPersonsNeeds, 
                         Staging.Cases.ForIllegalActivity, Staging.Cases.ForThingsAdultWouldNotPurchase, Staging.Cases.FrailElderly, Staging.Cases.GatedLockedCommunityBuilding, Staging.Cases.GenderCode, 
                         Staging.Cases.GiveAwayMoneyOrProperty, Staging.Cases.GrayAreas, Staging.Cases.GuardianOrConservatorInPlace, Staging.Cases.HarassesTheAdultInASexualManner, Staging.Cases.HasTheConditionBeenDiagnosed, 
                         Staging.Cases.HasThereBeenARecentChange, Staging.Cases.HaveSelfInjuriousBehavior, Staging.Cases.HealthcareMedicalNeeds, Staging.Cases.HelpFromFamilyFriendsOthers, Staging.Cases.HoardingIncludingAnimals, 
                         Staging.Cases.HoardingOrAnimalHoarding, Staging.Cases.IADLsCeaningLaundryCooking, Staging.Cases.IllegalActivityInTheHome, Staging.Cases.IllegalDrugManufacturing, Staging.Cases.IllegalDrugUse, 
                         Staging.Cases.ImminentForeclosuresOrEviction, Staging.Cases.ImpactAbilityToCommunicate, Staging.Cases.InappropriateConfinement, Staging.Cases.InappropriateRestraint, Staging.Cases.InappropriateSexualBehaviors, 
                         Staging.Cases.InitialAssessmentCompleteDate, Staging.Cases.InitialAssessmentDueDate, Staging.Cases.InitialCasePlanCompleteDate, Staging.Cases.InitialCasePlanDueDate, Staging.Cases.InitialResponseDate, 
                         Staging.Cases.InitialResponseDueDate, Staging.Cases.InitialResponseType, Staging.Cases.InProgressCasePlans, Staging.Cases.Interviews, Staging.Cases.InvestigationApprovalStatus, 
                         Staging.Cases.InvestigationCompletedDate, Staging.Cases.InvestigationDueDate, Staging.Cases.InWhatCapacityCoesPerpHaveAccess, Staging.Cases.IsThereAWillOrPowerOfAttorney, 
                         Staging.Cases.IsThisARecentChangeInBehavior, Staging.Cases.KnownCriminalActivityHistory, Staging.Cases.KnownGangActivity, Staging.Cases.LackOfAccessPathways, Staging.Cases.LastActivityChildObjects, 
                         Staging.Cases.LastActivityDate, Staging.Cases.LastModifiedById, Staging.Cases.LastModifiedDate, Staging.Cases.LastMonthlyContactDate, Staging.Cases.LastReferencedDate, Staging.Cases.LastViewedDate, 
                         Staging.Cases.LawEnforcementRequestedByAPS, Staging.Cases.MajorMentalIllnessEmotionalDisorder, Staging.Cases.MakeChangesToABankAccount, Staging.Cases.MakesSexualInnuendosTowardTheAdult, 
                         Staging.Cases.MakesTheAdultPerformSexualActs, Staging.Cases.MakesTheAdultWatchPornography, Staging.Cases.MalnutritionSuddenWeightLossGain, Staging.Cases.ManagingHomeCleanliness, 
                         Staging.Cases.MaritalStatusCode, Staging.Cases.MedicalConditions, Staging.Cases.MedicallyFragile, Staging.Cases.MedicationManagement, Staging.Cases.MemoryDecisionMakingProblems, 
                         Staging.Cases.MemoryDecisionMakingProblemsInfo, Staging.Cases.MemoryDeficits, Staging.Cases.MemoryProblems, Staging.Cases.MentalIllness, Staging.Cases.MismanagementOfMedications, 
                         Staging.Cases.MistreatmentCategory, Staging.Cases.MonthlyContactDueDate, Staging.Cases.NAMRSClientAge, Staging.Cases.NeurologicalImpairmentStrokeTBIMS, Staging.Cases.NewScreeninOutRecommendatio, 
                         Staging.Cases.NextCasePlanDueDate, Staging.Cases.NoAtRiskIssues, Staging.Cases.NoMistreatment, Staging.Cases.Nonworkingappliances, Staging.Cases.NonworkingUtilities, Staging.Cases.NoPhysicalMedicalCondition, 
                         Staging.Cases.OfCasePlans, Staging.Cases.XOfCases, Staging.Cases.XOfIntakes, Staging.Cases.XOFMonthlyContacts, Staging.Cases.OfNotYetImplementedClientServices, Staging.Cases.OfOpenAllegations, 
                         Staging.Cases.OfOpenPerpFindings, Staging.Cases.OfSubstantiatedAllegations, Staging.Cases.OngoingAllegedPerpetratorInvolvement, Staging.Cases.OngoingPerpetratorInvolvement, Staging.Cases.OtherInvolvedParties, 
                         Staging.Cases.OwnerId, Staging.Cases.OwnerProfile, Staging.Cases.PainAsAResultOfAPersonsActions, Staging.Cases.PerpLegalAuthorityType, Staging.Cases.PhysicalAbuse, Staging.Cases.PhysicalAbuseAdditionalDetails, 
                         Staging.Cases.PhysicalAbuseWereThereAnyWitnesses, Staging.Cases.PhysicalConditions, Staging.Cases.PhysicalImpairment, Staging.Cases.PhysicalMedicalAdditionalDetails, Staging.Cases.PhysicalMedicalConditions, 
                         Staging.Cases.PhysicalMedicalConditionsInformation, Staging.Cases.POAInPlace, Staging.Cases.PoliceFrequentlyCalledInToTheHome, Staging.Cases.PoorHygieneNotBathing, 
                         Staging.Cases.PreviousAssessmentCompletedDate, Staging.Cases.PreviousMonthlyContact, Staging.Cases.PrimaryLanguageCode, Staging.Cases.ProfessionalServicesInPlace, 
                         Staging.Cases.QuestionableTransferOfMoneyProperty, Staging.Cases.ReadyToCloseCase, Staging.Cases.ReAssessmentDueDate, Staging.Cases.LastAssessmentRiskScore, Staging.Cases.LastAssessmentSafetyScore, 
                         Staging.Cases.CaseID, Staging.Cases.RecordTypeID, Staging.Cases.RefusesRecommendedServices, Staging.Cases.ReportingPartyRelationshipRole, Staging.Cases.ReportingPartyRelationshipToClient, 
                         Staging.Cases.MandatedReport, Staging.Cases.ReportCameFromLawEnforcement, Staging.Cases.ReportingPartyName, Staging.Cases.ReportingPartyRelationshipNotes, Staging.Cases.RepPayeeInPlace, 
                         Staging.Cases.ResponseDueDate, Staging.Cases.ResponseExplanation, Staging.Cases.ReviewedByAPTeam_REF, Staging.Cases.RiskScoreDifference, Staging.Cases.RiskScoreOutcome, 
                         Staging.Cases.SafetyImprovementPercentage, Staging.Cases.SafetyPerception, Staging.Cases.SafetyScoreDifference, Staging.Cases.SafetyScoreOutcome, Staging.Cases.SafetyWarning, Staging.Cases.ScorecardReview, 
                         Staging.Cases.PhysicalAbuseScratches, Staging.Cases.SexualAbuseScratches, Staging.Cases.ScreenInScreenOutRecommendation, Staging.Cases.ScreenInOutSummary, Staging.Cases.ScreenOutReason, 
                         Staging.Cases.SecuritySystemCameras, Staging.Cases.SelfNeglect, Staging.Cases.SelfNeglectAdditionalDetails, Staging.Cases.SexualAbuse, Staging.Cases.SexualAbuseAdditionalDetails, 
                         Staging.Cases.SexualAbuseWereThereAnywitnesses, Staging.Cases.SignAQuitClaimDeed, Staging.Cases.SocialInteractionFamilyFriendsVisit, Staging.Cases.SpecifyIFNo, Staging.Cases.CaseClosedAdditionalInformation, 
                         Staging.Cases.SpecifyOtherCurrentLocation, Staging.Cases.SpecifyOtherRelationship, Staging.Cases.SpecifyOtherScreenOutReason, Staging.Cases.SpecifyWhyNoAssistanceWasReceived, Staging.Cases.Status, 
                         Staging.Cases.SubstanceAbuse, Staging.Cases.SelfNeglectSubstanceAbuse, Staging.Cases.SubstanceAbuseIncludingRXmeds, Staging.Cases.SubstantiatedExploitation, Staging.Cases.SumOfCountyFundsUsed, 
                         Staging.Cases.Supervisor_REF, Staging.Cases.SupervisorEmail, Staging.Cases.SupervisorName, Staging.Cases.SupportNetworkLivesWithClient, Staging.Cases.SupportNetworkNarrative, Staging.Cases.SystemModStamp, 
                         Staging.Cases.TeamMembers, Staging.Cases.TimelyInitialAssessment, Staging.Cases.TimelyInitialCasePlan, Staging.Cases.LateInitialResponse, Staging.Cases.TimelyInvestigation, Staging.Cases.TimelyMonthlyContact, 
                         Staging.Cases.ToDoAnythingTheyWouldntDoNormally, Staging.Cases.Transportation, Staging.Cases.UnableToCareForThemselves, Staging.Cases.UnableToCareForThemselvesInfo, 
                         Staging.Cases.UnableToProtectThemselvesCheckbox, Staging.Cases.UnableToProtectThemselves, Staging.Cases.UnableToProtectThemselvesInformation, Staging.Cases.UnexplainedLossOfMoneyProperty, 
                         Staging.Cases.UnknownAtRiskPopulation, Staging.Cases.MinorImpacts, Staging.Cases.SignificantImpacts, Staging.Cases.UnpaidUtilities, Staging.Cases.UnsafeNeighborhood, Staging.Cases.UnsafStructure, 
                         Staging.Cases.UntreatedMedicialCondition, Staging.Cases.UntreatedMentalHealthNeed, Staging.Cases.UntreatedMentalIllness, Staging.Cases.VerminPestInfestation, Staging.Cases.PhysicalAbuseVisibleMarks, 
                         Staging.Cases.SexualAbuseVisibleMarks, Staging.Cases.Wander, Staging.Cases.WasAssistanceReceived, Staging.Cases.WhatAreTheDetailsofTheConditions, Staging.Cases.WhatIsTheConcerYouWantToReport, 
                         Staging.Cases.WhyDidTheReportingPartyCall, Staging.Cases.WhatWouldBeHelpfulToImproeSituation, Staging.Cases.WhoIsResponsibleForAdultsCare, Staging.Cases.WithoutAdultsKnowledgePermission, 
                         Staging.Cases.SafetyNotes,  Staging.Cases.WorkerSafetyIssues, Staging.Cases.WorkerSafetyIssuesDesc, dbo.Users.Name AS Expr1
FROM            Staging.Cases INNER JOIN
                         dbo.Contacts ON Staging.Cases.ClientName = dbo.Contacts.ContactID INNER JOIN
                         dbo.Users ON Staging.Cases.LastModifiedById = dbo.Users.UserID
WHERE        (dbo.Contacts.LastName LIKE '%oseph%')
ORDER BY dbo.Contacts.LastName

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[15] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Cases (Staging)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 292
               Right = 341
            End
            DisplayFlags = 280
            TopColumn = 150
         End
         Begin Table = "Contacts"
            Begin Extent = 
               Top = 20
               Left = 526
               Bottom = 273
               Right = 849
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Users"
            Begin Extent = 
               Top = 6
               Left = 887
               Bottom = 252
               Right = 1072
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 323
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 3885
         Width = 3045
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'View_2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 4980
         Width = 1500
         Width = 5265
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 3495
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'View_2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane3', @value = N'         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 5055
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 4425
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 4500
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'View_2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 3, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'View_2';

