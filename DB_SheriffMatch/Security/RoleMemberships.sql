ALTER ROLE [db_owner] ADD MEMBER [CUYAHOGA\WEBERM];


GO
ALTER ROLE [db_ddladmin] ADD MEMBER [Cuy_DataLoader];


GO
ALTER ROLE [db_datareader] ADD MEMBER [Cuy_DataLoader];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [Cuy_DataLoader];

