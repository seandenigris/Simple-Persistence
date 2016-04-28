private
backupFileForVersion: aNumber

	^ self backupDirectory files detect: [:each | (self versionOf: each) = aNumber ] ifNone: [ nil ].