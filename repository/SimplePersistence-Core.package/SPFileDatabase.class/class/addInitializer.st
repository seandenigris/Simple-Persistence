setting up
addInitializer
	"Call on subclasses to add class initialization"

	self class compile:
'initialize

	self restoreLastBackup.
	self enablePersistence' classified: 'class initialization'.