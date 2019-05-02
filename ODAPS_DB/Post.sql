/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
IF NOT EXISTS (Select principal_id from sys.database_principals Where Name = 'Cuy_DataLoader')
BEGIN
	CREATE USER Cuy_DataLoader FOR LOGIN Cuy_DataLoader;
Exec sp_addrolemember 'db_datareader', @membername = 'Cuy_DataLoader';
Exec sp_addrolemember 'db_datawriter', @membername = 'Cuy_DataLoader';
Exec sp_addrolemember 'db_ddladmin', @membername = 'Cuy_DataLoader';
END