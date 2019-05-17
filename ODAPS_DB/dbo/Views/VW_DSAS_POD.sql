CREATE VIEW dbo.VW_DSAS_POD
AS
SELECT  sw.Name AS SocialWorker, sw.EMail AS SocialWorkerEmail, sw.Phone AS SocialWOrkerPhone, 
			sup.Name AS Supervisor, sup.phone AS SupervisorPhone  , 
            Staging.Cases.Supervisor_E_mail__c as SupervisorEmail, Staging.Cases.Client_Address__c AS ClientAddress  , 
			CONVERT(date, Staging.Cases.Referral_Submitted_Date_Time__c)   AS ReferralSubDate , 
				Staging.Cases.Comments, Staging.Contacts.Salutation, Staging.Contacts.FirstName, Staging.Contacts.LastName, 
                Staging.Contacts.Name AS ClientName, Staging.Contacts.MailingStreet, Staging.Contacts.MailingCity, 
				Staging.Contacts.MailingStateCode, Staging.Contacts.MailingPostalCode, 
                Staging.Contacts.Phone, Staging.Contacts.HomePhone, Staging.Contacts.Email, Staging.Contacts.Birthdate AS BirthDate, 
				Staging.Contacts.Approx_Age__c AS ApproxAge, 
				Staging.Contacts.Gender__c AS Gender, 
                Staging.Contacts.Income_Source__c AS IncomeSource, Staging.Contacts.Marital_Status__c AS MaritalStatus, 
				Staging.Contacts.Medicaid__c AS Medicaid, Staging.Contacts.Medicare__c AS Medicare, 
                Staging.Contacts.Race__c AS Race, Staging.Contacts.SSN__c AS SSN,   Staging.Contacts.Veteran_Status__c AS Veteran, 
				Staging.Contacts.Person_Id__c AS PersonID, Staging.Cases.Name AS CaseNumber, 
                iif((Staging.Cases.Caretaker_Neglect__c = 1), 'X', ' ') AS CaretakerNeglect, 
				iif((Staging.Cases.Sexual_Abuse__c = 1), 'X', ' ') AS SexualAbuse, 
				iif((Staging.Cases.Hoarding_or_animal_hoarding__c = 1), 'X', ' ') AS HoardingAnimal, 
                iif((Staging.Cases.Substance_abuse__c = 1), 'X', ' ') AS SubstanceAbuse, 
				iif((Staging.Cases.Bed_Bugs__c = 1), 'X', ' ') AS BedBugs, 
				iif((Staging.Cases.Emotional_Verbal_Abuse__c = 1), 'X', ' ') AS EmotionalVerbalAbuse, 
                iif((Staging.Cases.Physical_Abuse__c = 1), 'X', ' ') AS PhysicalAbuse, 
				iif((Staging.Cases.Self_Neglect__c = 1), 'X', ' ') AS SelfNeglect, 
				iif((Staging.Cases.Exploitation__c = 1), 'X', ' ') AS Exploitation,              
			   					 		 
			
				SUBSTRING( IIF( Staging.Cases.Self_Neglect__c = 1, ', Self-Neglect', '') + 
						   iif(Staging.Cases.Sexual_Abuse__c = 1, ', Sexual Abuse', ' ') + 
				           IIF(Staging.Cases.Bed_Bugs__c = 1, ', Bed Bugs', '') +  
				    	   IIF (Staging.Cases.Caretaker_Neglect__c = 1,  ', Neglect' ,  '')  + 
					       IIF(Staging.Cases.Hoarding_or_animal_hoarding__c = 1, ', Hoarding', '') + 
						   IIF(Staging.Cases.Substance_abuse__c = 1, ', Substance Abuse', '')  + 
					       IIF(Staging.Cases.Emotional_Verbal_Abuse__c = 1, ', Emotional/Verbal Abuse', '') + 
						   IIF(Staging.Cases.Physical_Abuse__c = 1, ', Physical Abuse', '')  + 
						   IIF(Staging.Cases.Exploitation__c = 1, ', Exploitation', ''),      3, 99999)  as Allegation,  	


						 
				iif((Staging.Cases.Diagnosed_Mental_Illness__c = 1), 'X', ' ') AS MentalIllness, 
				Staging.Cases.Diagnosed_Mental_Illness_Info__c AS MentalIllnessInfo, 
				ReportingParty.Name AS ReportingParty, 
                Staging.Cases.Reporting_Party_Agency_Name__c AS Agency, ReportingParty.MailingStreet AS ReportingMailingStreet, 
				ReportingParty.MailingCity AS ReportingMailingCity, 
                ReportingParty.MailingStateCode AS ReportingStateCode, ReportingParty.MailingPostalCode AS ReportingPostalCode, 
                ReportingParty.Phone AS ReportingPartyPhone
/*                         Staging.Contacts AS ReportingParty ON Staging.Cases.Reporting_Party_Name__c = ReportingParty.ID;*/ FROM Staging.Cases INNER JOIN
                Staging.Contacts ON Staging.Cases.Client_Name__c = Staging.Contacts.ID LEFT OUTER JOIN
                Staging.Users AS sw LEFT OUTER JOIN
                Staging.Users AS sup ON sw.Supervisor__c = sup.ID ON Staging.Cases.OwnerId = sw.ID LEFT OUTER JOIN
                Staging.Contacts AS ReportingParty ON Staging.Cases.Reporting_Party_Name__c = ReportingParty.ID
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_DSAS_POD';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_DSAS_POD';




GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[20] 4[6] 2[35] 3) )"
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
      Begin ColumnWidths = 54
         Width = 284
         Width = 1500
         Width = 1500
         Width = 2985
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 4590
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 3960
         Width = 1500
         Width = 1500
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_DSAS_POD';



