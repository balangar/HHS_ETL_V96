UPDATE sa
	Set
		sa.IsLoaded = 1,
		sa.LoadDate = getdate()
	From
		Staging.Accounts sa
		JOIN
		dbo.Accounts da
		ON sa.ID = da.ID
	Where
		sa.ID = da.ID