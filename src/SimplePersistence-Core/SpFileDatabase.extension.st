Extension { #name : #SpFileDatabase }

{ #category : #'*SimplePersistence-Core-Developer' }
SpFileDatabase class >> menuCommandOn: aBuilder [ 
	<worldMenu> 
	
	(aBuilder item: #'Simple Persistence')
		with: [
			(aBuilder item: #'Backup Browser')
				action: [ self backupBrowser ]; 
				icon: Smalltalk ui icons glamourousTable. ]
]

{ #category : #'*SimplePersistence-Core-Developer' }
SpFileDatabase class >> persist: aSymbol in: aClass [ 
	"See Object>>#persistIn:as:"

	SpFileDatabaseBehavior createFor: aClass persisting: aSymbol.
	SpPersistentBehavior addTo: aClass for: aSymbol.
]
