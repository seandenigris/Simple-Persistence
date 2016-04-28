setting up
persist: aSymbol in: aClass 

	self createFor: aClass persisting: aSymbol.
	PersistenceBehavior addTo: aClass for: aSymbol.