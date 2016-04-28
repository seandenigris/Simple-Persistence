*SimplePersistence-Core-Developer
persist: aSymbol in: aClass 
	"See Object>>#persistIn:as:"

	SpFileDatabaseBehavior createFor: aClass persisting: aSymbol.
	SpPersistentBehavior addTo: aClass for: aSymbol.