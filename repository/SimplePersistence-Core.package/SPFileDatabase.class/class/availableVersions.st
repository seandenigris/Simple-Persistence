private
availableVersions

	^ self backupFiles collect: [ :e | 
		self versionOf: e ].