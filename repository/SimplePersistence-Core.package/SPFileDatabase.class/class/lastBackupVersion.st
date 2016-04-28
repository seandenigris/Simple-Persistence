private
lastBackupVersion

	| lastBackupFile |
	lastBackupFile := self backupFiles detectMax: [:each | self versionOf: each].
	^ lastBackupFile isNil
		ifTrue: [ 0 ]
		ifFalse: [ self versionOf: lastBackupFile ].
	