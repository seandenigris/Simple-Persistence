private
backupFileForVersion: aNumber

	^ self backupFiles detect: [:each | (self versionOf: each) = aNumber ] ifNone: [ nil ].