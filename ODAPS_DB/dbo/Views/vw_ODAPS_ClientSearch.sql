CREATE VIEW dbo.vw_ODAPS_ClientSearch
AS
SELECT        sw.Name AS SocialWorker, sw.EMail AS SocialWorkerEmail, sw.Phone AS SocialWorkerPhone, sup.Name AS Supervisor, sup.Phone AS SupervisorPhone, Staging.Cases.Supervisor_E_mail__c AS SupervisorEmail, 
                         Staging.Cases.Client_Address__c AS ClientAddress, Staging.Cases.Referral_Submitted_Date_Time__c AS ReferralSubDate, Staging.Cases.Comments, Staging.Contacts.Salutation, Staging.Contacts.FirstName, 
                         Staging.Contacts.LastName, Staging.Contacts.Name AS ClientName, Staging.Contacts.MailingStreet, Staging.Contacts.MailingCity, Staging.Contacts.MailingStateCode, Staging.Contacts.MailingPostalCode, 
                         Staging.Contacts.Phone, Staging.Contacts.HomePhone, Staging.Contacts.Email, Staging.Contacts.Birthdate AS BirthDate, Staging.Contacts.Approx_Age__c AS ApproxAge, Staging.Contacts.Gender__c AS Gender, 
                         Staging.Contacts.Income_Source__c AS IncomeSource, Staging.Contacts.Marital_Status__c AS MaritalStatus, Staging.Contacts.Medicaid__c AS Medicaid, Staging.Contacts.Medicare__c AS Medicare, 
                         Staging.Contacts.Race__c AS Race, Staging.Contacts.Veteran_Status__c AS Veteran, Staging.Contacts.Person_Id__c AS PersonID, Staging.Cases.ID, Staging.CaseNotes.Case_Note_Interview_Date__c, 
                         Staging.CaseNotes.Characters_in_Note_Text__c
FROM            Staging.Cases INNER JOIN
                         Staging.Contacts ON Staging.Cases.Client_Name__c = Staging.Contacts.ID LEFT OUTER JOIN
                         Staging.CaseNotes ON Staging.Cases.ID = Staging.CaseNotes.APS_Case_Number__c LEFT OUTER JOIN
                         Staging.Users AS sw LEFT OUTER JOIN
                         Staging.Users AS sup ON sw.Supervisor__c = sup.ID ON Staging.Cases.OwnerId = sw.ID
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vw_ODAPS_ClientSearch';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vw_ODAPS_ClientSearch';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[34] 4[17] 2[19] 3) )"
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
               Bottom = 136
               Right = 310
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Contacts (Staging)"
            Begin Extent = 
               Top = 6
               Left = 348
               Bottom = 136
               Right = 613
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sw"
            Begin Extent = 
               Top = 6
               Left = 651
               Bottom = 136
               Right = 836
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sup"
            Begin Extent = 
               Top = 6
               Left = 874
               Bottom = 136
               Right = 1059
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CaseNotes (Staging)"
            Begin Extent = 
               Top = 176
               Left = 525
               Bottom = 306
               Right = 841
            End
            DisplayFlags = 280
            TopColumn = 19
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 51
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
         Width =', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vw_ODAPS_ClientSearch';

