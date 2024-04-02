Extension { #name : #SpFileDatabase }

{ #category : #'*SimplePersistence-Core-Developer' }
SpFileDatabase class >> persist: aSymbol in: aClass [ 
	"See Object>>#persistIn:as:"

	SpFileDatabaseBehavior createFor: aClass persisting: aSymbol.
	SpPersistentBehavior addTo: aClass for: aSymbol.
]
