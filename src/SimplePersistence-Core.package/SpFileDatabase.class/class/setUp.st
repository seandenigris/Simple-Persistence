private
setUp
	self isLibrary ifTrue: [ ^ self ].
	self restoreLastBackup.
	self enablePersistence