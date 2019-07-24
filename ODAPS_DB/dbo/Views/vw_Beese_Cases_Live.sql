CREATE VIEW dbo.[vw_Beese_Cases_Live]
AS
SELECT        sw.UserName, sw.Name AS SocialWorker, sw.EMail AS SocialWorkerEmail, sw.Phone AS SocialWOrkerPhone, sup.Name AS Supervisor, dbo.Cases.Client_Address__c, dbo.Cases.Caretaker_Neglect__c, 
                         dbo.Cases.Client_Name__c, dbo.Cases.Client_s_Age__c, dbo.Cases.Client_s_Home_Phone_Number__c, dbo.Cases.Exploitation__c, dbo.Cases.Physical_Abuse__c, dbo.Cases.Reporting_Party_Agency_Name__c AS Agency, 
                         dbo.Cases.Sexual_Abuse__c, dbo.Cases.Self_Neglect__c, dbo.Cases.Supervisor_E_mail__c, dbo.Cases.Hoarding_or_animal_hoarding__c, dbo.Cases.Emotional_Verbal_Abuse__c, 
                         dbo.Cases.Referral_Submitted_Date_Time__c AS ReferralSubDate, dbo.Cases.Bed_Bugs__c, dbo.Cases.Substance_abuse__c, dbo.Cases.Diagnosed_Mental_Illness_Info__c AS MentalIllnessInfo, 
                         dbo.Cases.Diagnosed_Mental_Illness__c AS MentalIllness, dbo.Contacts.Salutation, dbo.Contacts.FirstName, dbo.Contacts.LastName, dbo.Contacts.Name AS ClientName, dbo.Contacts.MailingStreet, dbo.Contacts.MailingCity, 
                         dbo.Contacts.MailingStateCode, dbo.Contacts.MailingPostalCode, dbo.Contacts.MailingAddress, dbo.Contacts.Phone, dbo.Contacts.HomePhone, dbo.Contacts.Email, dbo.Contacts.Birthdate, 
                         dbo.Contacts.Approx_Age__c AS ApproxAge, dbo.Contacts.Gender__c AS Gender, dbo.Contacts.Income_Source__c AS IncomeSource, dbo.Contacts.Marital_Status__c AS MaritalStatus, dbo.Contacts.Medicaid__c AS Medicaid, 
                         dbo.Contacts.Medicare__c AS Medicare, dbo.Contacts.Race__c AS Race, dbo.Contacts.SSN__c AS SSN, dbo.Contacts.Person_Id__c AS PersonID, dbo.Contacts.Veteran_Status__c AS Veteran, 
                         dbo.Contacts.Name AS ReportingParty, dbo.Contacts.MailingStreet AS ReportingMailingStreet, dbo.Contacts.MailingCity AS ReportingMailingCity, dbo.Contacts.MailingStateCode AS ReportingStateCode, 
                         dbo.Contacts.MailingPostalCode AS ReportingPostalCode
FROM            dbo.Users AS sup RIGHT OUTER JOIN
                         dbo.Users AS sw ON sup.ID = sw.SupervisorID RIGHT OUTER JOIN
                         dbo.Cases INNER JOIN
                         dbo.Contacts ON dbo.Cases.Client_Name__c = dbo.Contacts.ID ON sw.ID = dbo.Cases.OwnerId LEFT OUTER JOIN
                         dbo.Contacts AS ReportingParty ON dbo.Cases.Reporting_Party_Name__c = ReportingParty.ID
WHERE        (dbo.Cases.OwnerId = '005t0000002a8tsAAA')
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vw_Beese_Cases_Live';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'le = 1170
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vw_Beese_Cases_Live';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[13] 2[31] 3) )"
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
         Begin Table = "sup"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 239
               Right = 223
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sw"
            Begin Extent = 
               Top = 7
               Left = 278
               Bottom = 218
               Right = 463
            End
            DisplayFlags = 280
            TopColumn = 8
         End
         Begin Table = "Cases"
            Begin Extent = 
               Top = 6
               Left = 484
               Bottom = 247
               Right = 756
            End
            DisplayFlags = 280
            TopColumn = 31
         End
         Begin Table = "Contacts"
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
      Begin ColumnWidths = 9
         Width = 284
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
         Tab', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vw_Beese_Cases_Live';

