setting up
addInitializer
	"Call on subclasses to add class initialization"

	self databaseClass class compile:
'initialize
	self setUp.' classified: 'class initialization'.