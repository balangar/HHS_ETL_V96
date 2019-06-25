CREATE VIEW dbo.vw_DSAS_POD_Live
AS
SELECT        dbo.Contacts.Salutation, dbo.Contacts.FirstName, 
                         dbo.Contacts.LastName, dbo.Contacts.Name AS ClientName,  sw.Name AS SocialWorker, sw.EMail AS SocialWorkerEmail, sw.Phone AS SocialWorkerPhone, sup.Name AS Supervisor, sup.phone AS SupervisorPhone, dbo.Cases.Supervisor_E_mail__c AS SupervisorEmail, 
                         dbo.Cases.Client_Address__c AS ClientAddress, CONVERT(date, dbo.Cases.Referral_Submitted_Date_Time__c) AS ReferralSubDate, /* dbo.Cases.Comments, */ dbo.Contacts.MailingStreet, dbo.Contacts.MailingCity, dbo.Contacts.MailingStateCode, dbo.Contacts.MailingPostalCode, 
                         dbo.Contacts.Phone, dbo.Contacts.HomePhone, dbo.Contacts.Email, dbo.Contacts.Birthdate AS BirthDate, dbo.Contacts.Approx_Age__c AS ApproxAge, dbo.Contacts.Gender__c AS Gender, 
                         dbo.Contacts.Income_Source__c AS IncomeSource, dbo.Contacts.Marital_Status__c AS MaritalStatus, dbo.Contacts.Medicaid__c AS Medicaid, dbo.Contacts.Medicare__c AS Medicare, 
                         dbo.Contacts.Race__c AS Race, /*                                                       dbo.Contacts.SSN AS SSN,        */ dbo.Contacts.Veteran_Status__c AS Veteran, dbo.Contacts.Person_Id__c AS PersonID, 
                         dbo.Cases.Name AS CaseNumber, iif((dbo.Cases.Caretaker_Neglect__c = 1), 'X', ' ') AS CaretakerNeglect, iif((dbo.Cases.Sexual_Abuse__c = 1), 'X', ' ') AS SexualAbuse, 
                         iif((dbo.Cases.Hoarding_or_animal_hoarding__c = 1), 'X', ' ') AS HoardingAnimal, iif((dbo.Cases.Substance_abuse__c = 1), 'X', ' ') AS SubstanceAbuse, iif((dbo.Cases.Bed_Bugs__c = 1), 'X', ' ') AS BedBugs, 
                         iif((dbo.Cases.Emotional_Verbal_Abuse__c = 1), 'X', ' ') AS EmotionalVerbalAbuse, iif((dbo.Cases.Physical_Abuse__c = 1), 'X', ' ') AS PhysicalAbuse, iif((dbo.Cases.Self_Neglect__c = 1), 'X', ' ') AS SelfNeglect, 
                         iif((dbo.Cases.Exploitation__c = 1), 'X', ' ') AS Exploitation, SUBSTRING(IIF(dbo.Cases.Self_Neglect__c = 1, ', Self-Neglect', '') + iif(dbo.Cases.Sexual_Abuse__c = 1, ', Sexual Abuse', ' ') 
                         + IIF(dbo.Cases.Bed_Bugs__c = 1, ', Bed Bugs', '') + IIF(dbo.Cases.Caretaker_Neglect__c = 1, ', Neglect', '') + IIF(dbo.Cases.Hoarding_or_animal_hoarding__c = 1, ', Hoarding', '') 
                         + IIF(dbo.Cases.Substance_abuse__c = 1, ', Substance Abuse', '') + IIF(dbo.Cases.Emotional_Verbal_Abuse__c = 1, ', Emotional/Verbal Abuse', '') + IIF(dbo.Cases.Physical_Abuse__c = 1, ', Physical Abuse', '') 
                         + IIF(dbo.Cases.Exploitation__c = 1, ', Exploitation', ''), 3, 99999) AS Allegation, iif((dbo.Cases.Diagnosed_Mental_Illness__c = 1), 'X', ' ') AS MentalIllness, 
                         dbo.Cases.Diagnosed_Mental_Illness_Info__c AS MentalIllnessInfo, ReportingParty.Name AS ReportingParty, dbo.Cases.Reporting_Party_Agency_Name__c AS Agency, 
                         ReportingParty.MailingStreet AS ReportingMailingStreet, ReportingParty.MailingCity AS ReportingMailingCity, ReportingParty.MailingStateCode AS ReportingStateCode, 
                         ReportingParty.MailingPostalCode AS ReportingPostalCode, 
                         ReportingParty.Phone AS ReportingPartyPhone
/*                         dbo.Contacts AS ReportingParty ON dbo.Cases.Reporting_Party_Name__c = ReportingParty.ID;*/ 
FROM dbo.Cases INNER JOIN
                         dbo.Contacts ON dbo.Cases.Client_Name__c = dbo.Contacts.ID LEFT OUTER JOIN
                         dbo.Users AS sw LEFT OUTER JOIN
                         dbo.Users AS sup ON sw.SupervisorID = sup.ID ON dbo.Cases.OwnerId = sw.ID LEFT OUTER JOIN
                         dbo.Contacts AS ReportingParty ON dbo.Cases.Reporting_Party_Name__c = ReportingParty.ID
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vw_DSAS_POD_Live';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[32] 4[12] 2[31] 3) )"
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
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 50
         Width = 284
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
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vw_DSAS_POD_Live';

