accessing
schema
	"Return aCollection of classes for which we will be handling persistence
		Example: `^ { QuQuote. LivingLibraryDB }`; where 
			- QuQuote is a domain class that is part of our project
			- LivingLibraryDB is the DB from another project (LivingLibraryDB sbclass), which we will take over and persist as part of our model."
			
	self subclassResponsibility