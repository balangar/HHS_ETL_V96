/*
Insert INTO DSAS_ODAPS.dbo.Users(
	UserID, SupervisorID, LastName, FirstName, [Name], CreatedByID, CreatedDate, LastModifiedById, LastModifiedDate, SystemModstamp) 
Select 
	ID, SupervisorID, LastName, FirstName, [Name], CreatedByID, CreatedDate, LastModifiedById, LastModifiedDate, SystemModstamp 
FROM
	DSAS_ODAPS.temp.User
*/