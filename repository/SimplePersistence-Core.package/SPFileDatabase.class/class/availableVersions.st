private
availableVersions

	^ self backupDirectory files collect: [ :e | 
		self versionOf: e ].