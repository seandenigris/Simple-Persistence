setting up
saveRepository
	| version |
	lock ifNil: [ lock := Semaphore forMutualExclusion ].
	lock critical: [
		self trimBackups.
		version := self lastBackupVersion + 1.
		self serializer serialize: self repositories to: self backupDirectory / self name, version asString ].