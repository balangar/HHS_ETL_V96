Select
	Characters_in_Note_Text__c,
	Count_CharactersInNoteText = CONVERT(INT,ISNULL(SUBSTRING(Characters_in_Note_Text__c, 1, CHARINDEX('.', Characters_in_Note_Text__c) - 1), '0')),
	Days_Between_Contact_and_Today__c,
	Count_DaysBetweenContactAndToday = CONVERT(INT,ISNULL(SUBSTRING(Days_Between_Contact_And_Today__C, 1, CHARINDEX('.', Days_Between_Contact_And_Today__C) - 1), '0')),
	Days_Since_Note_Created__c,
	Days_since_last_assessment__c,
	*
From
	Staging.CaseNotes