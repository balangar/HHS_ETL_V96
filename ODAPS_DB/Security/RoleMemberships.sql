ALTER ROLE [db_ddladmin] ADD MEMBER [Cuy_DataLoader];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [Cuy_DataLoader];


GO
ALTER ROLE [db_datareader] ADD MEMBER [HHS_ReportWriter];


GO
ALTER ROLE [db_datareader] ADD MEMBER [Cuy_ReportWriter];


GO
ALTER ROLE [db_datareader] ADD MEMBER [Cuy_DataLoader];

