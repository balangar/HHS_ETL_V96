/*
 Pre-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be executed before the build script.	
 Use SQLCMD syntax to include a file in the pre-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the pre-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
USE [master]
GO

/****** Object:  Login [Cuy_ReadAllData]    Script Date: 3/12/2020 10:24:39 AM ******/
DROP LOGIN [Cuy_ReadAllData]
GO


/****** Object:  Login [Cuy_ReadAllData]    Script Date: 3/12/2020 10:24:39 AM ******/
CREATE LOGIN [Cuy_ReadAllData] WITH PASSWORD=N'lsmvRP8sJzw"A\Th2Lj+TZgeBRslMTIK', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF

GO
