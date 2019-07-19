/* WHERE        (Staging.CaseNotes.Case_Note_Interview_Date__c >= '2019-04-01')*/
CREATE VIEW dbo.vw_Case_to_CaseNotes_Staging
AS
SELECT        TOP (100) PERCENT Casenotes.Case_Note_Interview_Date__c, Casenotes.Note_Type__c, Casenotes.Note__c, Cases.ContactPersonID, Contacts.FirstName, Contacts.LastName, Cases.Name AS Case_Number, 
                         SW.Name AS Case_Manager, SW.Phone AS CM_Phone, Contacts.Name, Contacts.MailingStreet, Contacts.MailingCity, Contacts.MailingStateCode, Contacts.MailingPostalCode, Contacts.Birthdate, Contacts.Approx_Age__c, 
                         Contacts.Gender__c, Casenotes.Parent__c, Contacts.SSN__c, Cases.Case_Closed_Reason__c
FROM            Staging.Users AS SW INNER JOIN
                         Staging.Cases AS Cases ON SW.ID = Cases.OwnerId INNER JOIN
                         Staging.Users AS Sup ON SW.UserKey = Sup.UserKey LEFT OUTER JOIN
                         Staging.CaseNotes AS Casenotes ON Cases.ID = Casenotes.APS_Case_Number__c RIGHT OUTER JOIN
                         Staging.Contacts AS Contacts ON Cases.Client_Name__c = Contacts.ID
WHERE        (Casenotes.Case_Note_Interview_Date__c >= '2019-04-01') AND (Casenotes.Case_Note_Created_in_Error__c = 0)
ORDER BY Cases.ContactPersonID, Casenotes.Case_Note_Interview_Date__c, Casenotes.Parent__c
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vw_Case_to_CaseNotes_Staging';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
         Width = 1500
         Width = 1500
         Width = 1695
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 3165
         Width = 1500
         Width = 2655
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2370
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 4890
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 4530
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
         Column = 3900
         Alias = 3750
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 3435
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vw_Case_to_CaseNotes_Staging';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[25] 4[4] 2[27] 3) )"
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
         Begin Table = "SW"
            Begin Extent = 
               Top = 0
               Left = 998
               Bottom = 228
               Right = 1183
            End
            DisplayFlags = 280
            TopColumn = 9
         End
         Begin Table = "Cases"
            Begin Extent = 
               Top = 0
               Left = 284
               Bottom = 305
               Right = 556
            End
            DisplayFlags = 280
            TopColumn = 15
         End
         Begin Table = "Sup"
            Begin Extent = 
               Top = 6
               Left = 1221
               Bottom = 136
               Right = 1406
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Casenotes"
            Begin Extent = 
               Top = 62
               Left = 657
               Bottom = 282
               Right = 973
            End
            DisplayFlags = 280
            TopColumn = 37
         End
         Begin Table = "Contacts"
            Begin Extent = 
               Top = 20
               Left = 0
               Bottom = 337
               Right = 265
            End
            DisplayFlags = 280
            TopColumn = 28
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 54
         Width = 284
         Width = 1500
         Width = 1500
         Width = 2730
         Width = 3840
         Width = 3405
         Width = 2655
         Width = 2355
         Width = 1500
         Width = 3135
         Width = 1500
         Width = 1500
         Width = 5130
         Width = 1500
         Width = 1500', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vw_Case_to_CaseNotes_Staging';

