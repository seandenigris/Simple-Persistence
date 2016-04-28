saving
saveRepository
	| version |
	lock ifNil: [ lock := Semaphore forMutualExclusion ].
	lock critical: [
		self trimBackups.
		version := self lastBackupVersion + 1.
		ReferenceStream 
			newFileNamed: (self backupDirectory / self name, version asString) fullName
			do: [ :f | 
				f
					nextPut: self repositories;
					flush ] ].