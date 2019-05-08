
CREATE VIEW [dbo].[vw_APS_Case_Worker_Sup_ba]
AS
SELECT        Staging.Cases.ID, Staging.Contacts.Name AS Client, Staging.Contacts.Salutation, Staging.Contacts.MailingStreet, Staging.Contacts.MailingCity, Staging.Contacts.MailingStateCode, Staging.Contacts.MailingPostalCode, 
                         SW.Name AS Social_Worker, Sup.Name AS Supervisor
FROM            Staging.Cases INNER JOIN
                         dbo.Users AS SW ON Staging.Cases.OwnerId = SW.UserID LEFT OUTER JOIN
                         Staging.Contacts ON Staging.Cases.Reporting_Party_Name__c = Staging.Contacts.ID LEFT OUTER JOIN
                         dbo.Users AS Sup ON SW.SupervisorID = Sup.UserID