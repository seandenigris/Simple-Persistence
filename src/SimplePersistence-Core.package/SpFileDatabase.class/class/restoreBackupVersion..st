restoring
restoreBackupVersion: aNumber
	(self backupVersion: aNumber)
		ifNotNil: [ :backup | self restoreFrom: backup ]