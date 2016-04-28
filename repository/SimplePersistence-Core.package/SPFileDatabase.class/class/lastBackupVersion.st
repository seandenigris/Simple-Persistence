private
lastBackupVersion

	| lastBackupFile |
	lastBackupFile := self backupDirectory files detectMax: [:each | self versionOf: each].
	^ lastBackupFile isNil
		ifTrue: [ 0 ]
		ifFalse: [ self versionOf: lastBackupFile ].
	