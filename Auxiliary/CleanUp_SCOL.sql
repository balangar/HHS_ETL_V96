--USE OCSS_SCAS
--GO


--Select * from Staging.SCOL

--exec sp_rename 'Staging.SCOL.Field16', 'Arrearage_Text', 'COLUMN';	-- Safe because nothing else references ... yet. [geg] 2020-04-29

--ALTER TABLE Staging.SCOL
--	ADD  Arrearage DECIMAL(18,2) NULL;	

--SELECT TRY_CAST(LEFT(Arrearage_Text, 7) + '.' + RIGHT(Arrearage_Text,2) As Decimal(18,2)), * from Staging.SCOL

--BEGIN TRAN
--UPDATE Staging.SCOL
--	SET 
--		Arrearage = TRY_CAST(LEFT(Arrearage_Text, 7) + '.' + RIGHT(Arrearage_Text,2) As Decimal(18,2));

----Select * from Staging.SCOL

----ROLLBACK
--COMMIT

--ALTER TABLE Staging.SCOL
--	DROP COLUMN Arrearage_Text;

--Select * from Staging.SCOL

--exec sp_rename 'Staging.SCOL.Field18', 'LastMonthPayments_Text', 'COLUMN';	-- Safe because nothing else references ... yet. [geg] 2020-04-29

--ALTER TABLE Staging.SCOL
--	ADD  LastMonthPayments DECIMAL(18,2) NULL;	


--BEGIN TRAN
--UPDATE Staging.SCOL
--	SET 
--		LastmonthPayments = TRY_CAST(LEFT(LastMonthPayments_Text, 7) + '.' + RIGHT(LastMonthPayments_Text,2) As Decimal(18,2));

----Select * from Staging.SCOL

----ROLLBACK
--COMMIT

--ALTER TABLE Staging.SCOL
--	DROP COLUMN LastMonthPayments_Text;


--Select * from Staging.SCOL

--exec sp_rename 'Staging.SCOL.Field20', 'TotalPayments_Text', 'COLUMN';	-- Safe because nothing else references ... yet. [geg] 2020-04-29

--ALTER TABLE Staging.SCOL
--	ADD  TotalPayments DECIMAL(18,2) NULL;	

--BEGIN TRAN
--UPDATE Staging.SCOL
--	SET 
--		TotalPayments = TRY_CAST(LEFT(TotalPayments_Text, 7) + '.' + RIGHT(TotalPayments_Text,2) As Decimal(18,2));

----Select * from Staging.SCOL

----ROLLBACK
--COMMIT

--ALTER TABLE Staging.SCOL
--	DROP COLUMN TotalPayments_Text;


--Select LEN(Last10Events_Text), len(Last10Events_Text) / 3, Left(Last10Events_Text,2), Last10Events_Text,  * from Staging.SCOL

--Select * from Staging.SCOL

--exec sp_rename 'Staging.SCOL.Field22', 'Last10Events_Text', 'COLUMN';	-- Safe because nothing else references ... yet. [geg] 2020-04-29

--ALTER TABLE Staging.SCOL
--	ADD  Last10Events_CSV VARCHAR(40) NULL;


--DECLARE @Last10Events_Text as VARCHAR(30)
--DECLARE @Key As VARCHAR(18)

--DECLARE Events CURSOR FOR
--Select [Key], Last10Events_Text from Staging.SCOL Where Last10Events_Text IS NOT NULL

--OPEN Events
--FETCH NEXT FROM Events INTO @Key, @Last10Events_Text

--WHILE @@FETCH_STATUS = 0
--BEGIN
--	DECLARE @Count INTEGER = 1
--	DECLARE @MaxCount INTEGER = ISNULL(LEN(@Last10Events_Text) / 3, 0)
--	DECLARE @Txt VARCHAR(40) = ''

--	WHILE @Count <= @MaxCount
--	BEGIN
--		SET @Txt = @Txt + SUBSTRING(@Last10Events_Text, (@Count -1) * 3 + 1, 3) + ','
--		SET @Count += 1
--	END

--	SET @Txt = STUFF(@Txt, LEN(@Txt), 1, '')	-- Kill the trailing ',' (comma).  A bit of a hack.  [geg]

--	UPDATE Staging.SCOL
--		Set
--			Last10Events_CSV = @Txt
--		Where
--			[Key] = @Key

--	FETCH NEXT FROM Events INTO @Key, @Last10Events_Text
--END

--CLOSE Events  
--DEALLOCATE Events 

--Alter Schema dbo Transfer Staging.SCol


		