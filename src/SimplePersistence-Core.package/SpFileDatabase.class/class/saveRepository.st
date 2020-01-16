saving
saveRepository
	<script>
	| version |
	lock ifNil: [ lock := Semaphore forMutualExclusion ].
	lock critical: [
		self trimBackups.
		version := self lastBackupVersion + 1.
		self serializer serialize: self spData to: self backupDirectory / self name, version asString ].