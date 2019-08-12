MERGE
	DSAS_ODAPS.dbo.Accounts As Target
	USING DSAS_ODAPS.Staging.Accounts As [Source]
	ON
		Target.ID = [Source].ID

	WHEN MATCHED And
		[Source].IsValid = 1 And [Source].IsLoaded != 1 And
		Target.SysModifyDate < [Source].SysInsertDate And
		Target.HashSignature != [Source].HashSignature
	THEN
		UPDATE
			SET
				Target.SysModifyDate = [Source].SysInsertDate,
				Target.HashSignature = [Source].HashSignature,

				Target.CreatedByID = [Source].CreatedByID,
				Target.CreatedDate = [Source].CreatedDate,
				Target.LastModifiedByID = [Source].LastModifiedByID,
				Target.LastModifiedDate = [Source].LastModifiedDate,
				Target.SystemModstamp = [Source].SystemModStamp,
				Target.IsDeleted = [Source].IsDeleted,

				Target.MasterRecordID = [Source].MasterRecordID,
				Target.OwnerID = [Source].OwnerID,
				Target.ParentID = [Source].ParentID,
				Target.RecordTypeID = [Source].RecordTypeID,

				Target.Type = [Source].Type,
				Target.[Name] = [Source].[Name],
				Target.[Description] = [Source].[Description],

				Target.LastActivityDate = [Source].LastActivityDate,
				Target.LastViewedDate = [Source].LastViewedDate,
				Target.LastReferencedDate = [Source].LastReferencedDate


	WHEN NOT MATCHED By Target And [Source].IsValid = 1
	THEN
		INSERT
		(
			SysInsertDate, SysModifyDate, HashSignature,
			ID, CreatedByID, CreatedDate, LastModifiedByID, LastModifiedDate, SystemModstamp, IsDeleted,
			MasterRecordId, OwnerID, ParentID, RecordTypeID,
			[Type], [Name], [Description],
			LastActivityDate, LastViewedDate, LastReferencedDate
		)
		VALUES
		(
			Source.SysInsertDate, Source.SysInsertDate, Source.HashSignature,
			Source.ID, Source.CreatedByID, Source.CreatedDate, Source.LastModifiedByID, Source.LastModifiedDate, Source.SystemModstamp, Source.IsDeleted,
			Source.MasterRecordId, Source.OwnerID, Source.ParentID, Source.RecordTypeID,
			Source.Type, Source.Name, Source.Description,
			Source.LastActivityDate, Source.LastviewedDate,Source.LastReferencedDate
		)
;