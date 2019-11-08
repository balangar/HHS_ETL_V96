﻿CREATE VIEW dbo.vw_Beese_Cases
AS
SELECT        sw.UserName, sw.Name AS SocialWorker, sw.EMail AS SocialWorkerEmail, sw.Phone AS SocialWOrkerPhone, Staging.Users.Name AS Supervisor, Staging.Cases.Client_Address__c, Staging.Cases.Caretaker_Neglect__c, 
                         Staging.Cases.Client_Name__c, Staging.Cases.Client_s_Age__c, Staging.Cases.Client_s_Home_Phone_Number__c, Staging.Cases.Exploitation__c, Staging.Cases.Physical_Abuse__c, 
                         Staging.Cases.Reporting_Party_Agency_Name__c AS Agency, Staging.Cases.Sexual_Abuse__c, Staging.Cases.Self_Neglect__c, Staging.Cases.Supervisor_E_mail__c, Staging.Cases.Hoarding_or_animal_hoarding__c, 
                         Staging.Cases.Emotional_Verbal_Abuse__c, Staging.Cases.Referral_Submitted_Date_Time__c AS ReferralSubDate, Staging.Cases.Bed_Bugs__c, Staging.Cases.Substance_abuse__c, 
                         Staging.Cases.Diagnosed_Mental_Illness_Info__c AS MentalIllnessInfo, Staging.Cases.Diagnosed_Mental_Illness__c AS MentalIllness, Staging.Cases.Comments, Staging.Contacts.Salutation, Staging.Contacts.FirstName, 
                         Staging.Contacts.LastName, Staging.Contacts.Name AS ClientName, Staging.Contacts.MailingStreet, Staging.Contacts.MailingCity, Staging.Contacts.MailingStateCode, Staging.Contacts.MailingPostalCode, 
                         Staging.Contacts.MailingAddress, Staging.Contacts.Phone, Staging.Contacts.HomePhone, Staging.Contacts.Email, Staging.Contacts.Birthdate, Staging.Contacts.Approx_Age__c AS ApproxAge, 
                         Staging.Contacts.Gender__c AS Gender, Staging.Contacts.Income_Source__c AS IncomeSource, Staging.Contacts.Marital_Status__c AS MaritalStatus, Staging.Contacts.Medicaid__c AS Medicaid, 
                         Staging.Contacts.Medicare__c AS Medicare, Staging.Contacts.Race__c AS Race, Staging.Contacts.SSN__c AS SSN, Staging.Contacts.Person_Id__c AS PersonID, Staging.Contacts.Veteran_Status__c AS Veteran, 
                         Staging.Contacts.Name AS ReportingParty, Staging.Contacts.MailingStreet AS ReportingMailingStreet, Staging.Contacts.MailingCity AS ReportingMailingCity, Staging.Contacts.MailingStateCode AS ReportingStateCode, 
                         Staging.Contacts.MailingPostalCode AS ReportingPostalCode
FROM            Staging.Users INNER JOIN
                         Staging.Users AS sw ON Staging.Users.ID = sw.Supervisor__c RIGHT OUTER JOIN
                         Staging.Cases INNER JOIN
                         Staging.Contacts ON Staging.Cases.Client_Name__c = Staging.Contacts.ID ON sw.ID = Staging.Cases.OwnerId LEFT OUTER JOIN
                         Staging.Contacts AS ReportingParty ON Staging.Cases.Reporting_Party_Name__c = ReportingParty.ID
WHERE        (Staging.Cases.OwnerId = '005t0000002a8tsAAA')
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vw_Beese_Cases';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'idth = 1500
         Width = 3570
         Width = 1500
         Width = 1500
         Width = 3810
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
         Column = 4005
         Alias = 4215
         Table = 4230
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 3975
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vw_Beese_Cases';




GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[33] 4[17] 2[17] 3) )"
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
         Begin Table = "Users (Staging)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 218
               Right = 223
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sw"
            Begin Extent = 
               Top = 6
               Left = 261
               Bottom = 136
               Right = 446
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Cases (Staging)"
            Begin Extent = 
               Top = 6
               Left = 484
               Bottom = 136
               Right = 756
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Contacts (Staging)"
            Begin Extent = 
               Top = 6
               Left = 794
               Bottom = 136
               Right = 1059
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ReportingParty"
            Begin Extent = 
               Top = 6
               Left = 1097
               Bottom = 136
               Right = 1362
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
      Begin ColumnWidths = 61
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
         W', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vw_Beese_Cases';


