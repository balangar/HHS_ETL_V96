CREATE VIEW dbo.View_11
AS
SELECT        TOP (100) PERCENT dbo.CaseNotes.Case_Note_Interview_Date__c, dbo.CaseNotes.Note_Type__c, dbo.CaseNotes.Note__c, Cases.ContactPersonID, dbo.Contacts.FirstName, dbo.Contacts.LastName, 
                         Cases.Name AS Case_Number, dbo.vw_Sup_Sw_List.SocialWorker AS Case_Manager, dbo.vw_Sup_Sw_List.SW_Phone AS CM_Phone, dbo.Contacts.Name, dbo.Contacts.MailingStreet, dbo.Contacts.MailingCity, 
                         dbo.Contacts.MailingStateCode, dbo.Contacts.MailingPostalCode, dbo.Contacts.Birthdate, dbo.Contacts.Approx_Age__c, dbo.Contacts.Gender__c, dbo.CaseNotes.Parent__c, dbo.Contacts.SSN__c, 
                         Cases.Case_Closed_Reason__c, dbo.CaseNotes.Case_Note_Created_in_Error__c
FROM            dbo.Cases AS Cases LEFT OUTER JOIN
                         dbo.vw_Sup_Sw_List ON Cases.OwnerId = dbo.vw_Sup_Sw_List.SW_ID RIGHT OUTER JOIN
                         dbo.Contacts ON Cases.ContactPersonID = dbo.Contacts.Person_Id__c LEFT OUTER JOIN
                         dbo.CaseNotes ON Cases.ID = dbo.CaseNotes.APS_Case_Number__c
WHERE        (dbo.CaseNotes.Case_Note_Created_in_Error__c IS NULL) AND (dbo.CaseNotes.Case_Note_Interview_Date__c > CONVERT(DATETIME, '2019-04-01 00:00:00', 102)) OR
                         (dbo.CaseNotes.Case_Note_Created_in_Error__c = 0) AND (dbo.CaseNotes.Case_Note_Interview_Date__c > CONVERT(DATETIME, '2019-04-01 00:00:00', 102))
ORDER BY Cases.ContactPersonID, dbo.CaseNotes.Case_Note_Interview_Date__c, dbo.CaseNotes.Parent__c
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'View_11';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' Column = 3855
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'View_11';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[36] 4[29] 2[13] 3) )"
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
         Begin Table = "Cases"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 310
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_Sup_Sw_List"
            Begin Extent = 
               Top = 174
               Left = 399
               Bottom = 399
               Right = 569
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Contacts"
            Begin Extent = 
               Top = 6
               Left = 556
               Bottom = 136
               Right = 821
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CaseNotes"
            Begin Extent = 
               Top = 6
               Left = 859
               Bottom = 177
               Right = 1175
            End
            DisplayFlags = 280
            TopColumn = 38
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 22
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
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
        ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'View_11';

