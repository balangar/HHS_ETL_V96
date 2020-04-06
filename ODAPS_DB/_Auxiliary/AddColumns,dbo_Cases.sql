ALTER TABLE dbo.Cases
	ADD
		[Status__c]						   VARCHAR (255)  NULL,
		[Case_Stage__c]					   VARCHAR (255)  NULL,
		[Date_Case_Closed__c]			   VARCHAR (50)	  NULL,
		[Days_Open__c]					   VARCHAR (50)	  NULL,
		[Screen_Out_Reason__c]             VARCHAR (255)  NULL,
		[Screened_Out_Date_Time__c]        VARCHAR (50)   NULL,
		[Report_Effective_Date_Time__c]    VARCHAR (50)   NULL
		;
