SELECT   
     sw.UserName
  ,sw.Name AS SocialWorker
, sw.EMail AS SocialWorkerEmail
, sw.Phone AS SocialWOrkerPhone
, sup.Name AS Supervisor
, sup.phone as SupervisorPhone
--, Staging.Cases.Caretaker_Neglect__c
--, Staging.Cases.Client_s_Home_Phone_Number__c
--, Staging.Cases.Exploitation__c
--, Staging.Cases.Physical_Abuse__c
--, Staging.Cases.Sexual_Abuse__c
--, Staging.Cases.Self_Neglect__c
, Staging.Cases.Supervisor_E_mail__c
, Staging.Cases.Client_Address__c as ClientAddress
--, Staging.Cases.Hoarding_or_animal_hoarding__c
--, Staging.Cases.Emotional_Verbal_Abuse__c
, convert(date,Staging.Cases.Referral_Submitted_Date_Time__c) AS ReferralSubDate
--, Staging.Cases.Bed_Bugs__c
--, Staging.Cases.Substance_abuse__c
--, Staging.Cases.Diagnosed_Mental_Illness__c AS MentalIllness
, Staging.Cases.Comments, Staging.Contacts.Salutation
, Staging.Contacts.FirstName
, Staging.Contacts.LastName
, Staging.Contacts.Name AS ClientName
, Staging.Contacts.MailingStreet
, Staging.Contacts.MailingCity
, Staging.Contacts.MailingStateCode
, Staging.Contacts.MailingPostalCode
, Staging.Contacts.MailingAddress
, Staging.Contacts.Phone
, Staging.Contacts.HomePhone
, Staging.Contacts.Email
, Staging.Contacts.Birthdate AS BirthDate
, Staging.Contacts.Approx_Age__c AS ApproxAge
, Staging.Contacts.Gender__c AS Gender
, Staging.Contacts.Income_Source__c AS IncomeSource
, Staging.Contacts.Marital_Status__c AS MaritalStatus
, Staging.Contacts.Medicaid__c AS Medicaid
, Staging.Contacts.Medicare__c AS Medicare
, Staging.Contacts.Race__c AS Race
, Staging.Contacts.SSN__c AS SSN
, Staging.Contacts.Veteran_Status__c AS Veteran
, Staging.Contacts.Person_Id__c AS PersonID
, Staging.Cases.Name AS EncounterNumber
,iif((Staging.Cases.Caretaker_Neglect__c = 1), 'X', '') as CaretakerNeglect
,iif((Staging.Cases.Sexual_Abuse__c = 1), 'X', '') as SexualAbuse
,iif((Staging.Cases.Hoarding_or_animal_hoarding__c = 1), 'X', '') as HoardingAnimal
,iif((Staging.Cases.Substance_abuse__c = 1), 'X', '') as SubstanceAbuse
,iif((Staging.Cases.Bed_Bugs__c  = 1), 'X', '') as BedBugs
,iif((Staging.Cases.Emotional_Verbal_Abuse__c = 1), 'X', '') as EmotionalVerbalAbuse
,iif((Staging.Cases.Physical_Abuse__c = 1), 'X', '') as PhysicalAbuse
,iif((Staging.Cases.Self_Neglect__c = 1), 'X', '') as SelfNeglect
,iif((Staging.Cases.Exploitation__c = 1), 'X', '') as Exploitation
,iif((Staging.Cases.Diagnosed_Mental_Illness__c  = 1), 'X', '') as  MentalIllness
, Staging.Cases.Diagnosed_Mental_Illness_Info__c AS MentalIllnessInfo
, ReportingParty.Name AS ReportingParty
, Staging.Cases.Reporting_Party_Agency_Name__c AS Agency
, ReportingParty.MailingStreet AS ReportingMailingStreet
, ReportingParty.MailingCity AS ReportingMailingCity
, ReportingParty.MailingStateCode AS ReportingStateCode
, ReportingParty.MailingPostalCode AS ReportingPostalCode
, ReportingParty.MailingAddress AS ReportingMailingAddress
, ReportingParty.Phone AS ReportingPartyPhone
--FROM            Staging.Users right outer jOIN
--                         Staging.Users AS sw ON Staging.Users.ID = sw.Supervisor__c RIGHT OUTER JOIN
--                         Staging.Cases INNER JOIN
--                         Staging.Contacts  ON Staging.Cases.Client_Name__c = Staging.Contacts.ID ON sw.ID = Staging.Cases.OwnerId LEFT OUTER JOIN
--                         Staging.Contacts AS ReportingParty ON Staging.Cases.Reporting_Party_Name__c = ReportingParty.ID;
						 FROM            Staging.Cases INNER JOIN
                         Staging.Contacts ON Staging.Cases.Client_Name__c = Staging.Contacts.ID LEFT OUTER JOIN
                         Staging.Users AS sw left outer JOIN
                         Staging.Users AS sup ON sw.Supervisor__c = sup.ID ON Staging.Cases.OwnerId = sw.ID LEFT OUTER JOIN
                         Staging.Contacts AS ReportingParty ON Staging.Cases.Reporting_Party_Name__c = ReportingParty.ID	

