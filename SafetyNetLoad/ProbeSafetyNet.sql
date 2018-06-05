USE SafetyNet
GO

Select * from dbo.Staging_TimeLimited
Select * from dbo.Staging_Referrals
Select * from dbo.Referrals_QA Where SysinsertDate > '6/7/2017'
Select * from dbo.Referrals where sysinsertdate > '6/7/2017' order by RecordCounter
Select * from dbo.Referral_Notifications where sysinsertdate > '6/7/2017' order by RecordCounter



--Delete From dbo.Staging_Referrals

--Delete from dbo.Referrals_QA Where SysinsertDate > '6/7/2017'
--Delete from dbo.Referrals  Where SysinsertDate > '6/7/2017'
--Delete from dbo.Referral_Notifications where sysinsertdate > '6/7/2017' 

Select MAX(RecordCounter) from dbo.Referrals
Select MAX(RecordCounter) from dbo.Referral_Notifications



