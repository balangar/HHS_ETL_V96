CREATE VIEW dbo.View_6
AS
SELECT        Staging.CaseNotes.CaseNoteKey, Staging.CaseNotes.SysInsertUser, Staging.CaseNotes.SysInsertDate, Staging.CaseNotes.HashSignature, Staging.CaseNotes.Id, Staging.CaseNotes.CreatedDate, 
                         Staging.CaseNotes.CreatedById, Staging.CaseNotes.LastModifiedDate, Staging.CaseNotes.LastModifiedById, Staging.CaseNotes.SystemModstamp, Staging.CaseNotes.IsDeleted, Staging.CaseNotes.RecordTypeId, 
                         Staging.CaseNotes.Name, Staging.CaseNotes.LastActivityDate, Staging.CaseNotes.LastViewedDate, Staging.CaseNotes.LastReferencedDate, Staging.CaseNotes.APS_Case_Number__c, Staging.CaseNotes.APSClientName__c, 
                         Staging.CaseNotes.Case_Note_Create_Date_Only__c, Staging.CaseNotes.Case_Note_Interview_Date__c, Staging.CaseNotes.Characters_in_Note_Text__c, Staging.CaseNotes.Client_Interview_Outside_Perp_Presence__c, 
                         Staging.CaseNotes.Client_Interview__c, Staging.CaseNotes.Client_Name__c, Staging.CaseNotes.Contact_is_Timely__c, Staging.CaseNotes.Copy_of_first_255_char_in_note__c, 
                         Staging.CaseNotes.Days_Between_Contact_and_Today__c, Staging.CaseNotes.Days_Since_Note_Created__c, Staging.CaseNotes.Days_since_last_assessment__c, 
                         Staging.CaseNotes.Explain_Why_Perp_Attended_Interview__c, Staging.CaseNotes.Interview_Conducted_With__c, Staging.CaseNotes.Non_Participating_Contact__c, Staging.CaseNotes.Note_Created_Contact_Date__c, 
                         Staging.CaseNotes.Note_Type__c, Staging.CaseNotes.Note__c, Staging.CaseNotes.TemporaryAPSCase__c, Staging.CaseNotes.Case_Note_Created_in_Error__c, Staging.CaseNotes.Case_Note__c, 
                         Staging.CaseNotes.Status__c, Staging.CaseNotes.Supervisor_Email__c, Staging.CaseNotes.Created_in_Error_Formatted__c, Staging.CaseNotes.Parent__c, Staging.CaseNotes.IsValid, Staging.CaseNotes.IsLoaded, 
                         Staging.CaseNotes.LoadDate, Staging.CaseNotes.Comments, Staging.Cases.CaseKey, Staging.Cases.SysInsertUser AS Expr1, Staging.Cases.SysInsertDate AS Expr2, Staging.Cases.HashSignature AS Expr3, 
                         Staging.Cases.ID AS Expr4, Staging.Cases.CreatedById AS Expr5, Staging.Cases.CreatedDate AS Expr6, Staging.Cases.LastModifiedById AS Expr7, Staging.Cases.LastModifiedDate AS Expr8, 
                         Staging.Cases.SystemModStamp AS Expr9, Staging.Cases.OwnerId, Staging.Cases.RecordTypeID AS Expr10, Staging.Cases.Owner_County__c, Staging.Cases.IsDeleted AS Expr11, Staging.Cases.Name AS Expr12, 
                         Staging.Cases.ContactPersonID, Staging.Cases.CaseSeqNo, Staging.Cases.Approximate_Age__c, Staging.Cases.Caretaker_Neglect__c, Staging.Cases.Client_Address__c, Staging.Cases.Client_Name__c AS Expr13, 
                         Staging.Cases.Client_s_Age__c, Staging.Cases.Client_s_Home_Phone_Number__c, Staging.Cases.Date_of_Birth__c, Staging.Cases.Exploitation__c, Staging.Cases.Gender_Code__c, Staging.Cases.Marital_Status_Code__c, 
                         Staging.Cases.Physical_Abuse__c, Staging.Cases.Reporting_Party_Agency_Name__c, Staging.Cases.Reporting_Party_Name__c, Staging.Cases.Self_Neglect__c, Staging.Cases.Sexual_Abuse__c, 
                         Staging.Cases.Supervisor_E_mail__c, Staging.Cases.Supervisor_Name__c, Staging.Cases.Supervisor__c, Staging.Cases.Hoarding_or_animal_hoarding__c, Staging.Cases.Emotional_Verbal_Abuse__c, 
                         Staging.Cases.Referral_Submitted_Date_Time__c, Staging.Cases.Bed_Bugs__c, Staging.Cases.Substance_abuse__c, Staging.Cases.Diagnosed_Mental_Illness_Info__c, Staging.Cases.Diagnosed_Mental_Illness__c, 
                         Staging.Cases.IsValid AS Expr14, Staging.Cases.IsLoaded AS Expr15, Staging.Cases.LoadDate AS Expr16, Staging.Cases.Comments AS Expr17, Staging.Contacts.ContactKey, Staging.Contacts.SysInsertUser AS Expr18, 
                         Staging.Contacts.SysInsertDate AS Expr19, Staging.Contacts.HashSignature AS Expr20, Staging.Contacts.ID AS Expr21, Staging.Contacts.CreatedByID AS Expr22, Staging.Contacts.CreatedDate AS Expr23, 
                         Staging.Contacts.LastModifiedById AS Expr24, Staging.Contacts.LastModifiedDate AS Expr25, Staging.Contacts.SystemModstamp AS Expr26, Staging.Contacts.OwnerId AS Expr27, Staging.Contacts.AccountId, 
                         Staging.Contacts.MasterRecordId, Staging.Contacts.IsDeleted AS Expr28, Staging.Contacts.Salutation, Staging.Contacts.FirstName, Staging.Contacts.LastName, Staging.Contacts.Name AS Expr29, Staging.Contacts.MailingStreet,
                          Staging.Contacts.MailingCity, Staging.Contacts.MailingStateCode, Staging.Contacts.MailingPostalCode, Staging.Contacts.MailingAddress, Staging.Contacts.Phone, Staging.Contacts.HomePhone, Staging.Contacts.Email, 
                         Staging.Contacts.Birthdate, Staging.Contacts.Approx_Age__c, Staging.Contacts.Gender_Code__c AS Expr30, Staging.Contacts.Gender__c, Staging.Contacts.Hoarding_or_animal_hoarding__c AS Expr31, 
                         Staging.Contacts.Income_Source__c, Staging.Contacts.Marital_Status__c, Staging.Contacts.Medicaid__c, Staging.Contacts.Medicare__c, Staging.Contacts.Race__c, Staging.Contacts.SSN__c, Staging.Contacts.Person_Id__c, 
                         Staging.Contacts.Veteran_Status__c, Staging.Contacts.Bed_Bugs__c AS Expr32, Staging.Contacts.IsValid AS Expr33, Staging.Contacts.IsLoaded AS Expr34, Staging.Contacts.LoadDate AS Expr35, 
                         Staging.Contacts.Comments AS Expr36
FROM            Staging.CaseNotes RIGHT OUTER JOIN
                         Staging.Cases ON Staging.CaseNotes.APS_Case_Number__c = Staging.Cases.ID RIGHT OUTER JOIN
                         Staging.Contacts ON Staging.Cases.Client_Name__c = Staging.Contacts.ID
WHERE        (Staging.Cases.ContactPersonID = '256224') AND (Staging.CaseNotes.Case_Note_Interview_Date__c >= '2019-04-01')
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'View_6';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "CaseNotes (Staging)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 354
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Cases (Staging)"
            Begin Extent = 
               Top = 6
               Left = 392
               Bottom = 136
               Right = 664
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Contacts (Staging)"
            Begin Extent = 
               Top = 6
               Left = 702
               Bottom = 136
               Right = 967
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'View_6';

