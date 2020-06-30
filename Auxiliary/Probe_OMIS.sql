--Truncate Table Staging.OMIS;

Select Count(*) from Staging.OMIS;

Select top 10 * from Staging.OMIS Where CaseNumber = 'A000835801'

Select GroupNumber, Count(GroupNumber) as Groups from Staging.OMIS group by GroupNumber Having Count(GroupNumber) > 1 order by Groups desc

Select * from staging.OMIS where groupnumber = 140150

Select * from Staging.OMIS order by ID desc

Select Distinct AbeyanceIndicator From Staging.OMIS

Select * from Staging.OMIS Where AbeyanceIndicator = ' '
