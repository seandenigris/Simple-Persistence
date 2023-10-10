Class {
	#name : #SimplePersistenceTests,
	#superclass : #TestCase,
	#category : #'SimplePersistence-Tests'
}

{ #category : #accessing }
SimplePersistenceTests >> testDataMigration [

	| db objectToStore |
	db := SpTestDatabase.
	objectToStore := SpDummyClassForTesting new.
	objectToStore instVarNamed: #name put: 'me'.
	
	db 
		spData: objectToStore;
		saveRepository.
	
	db reset; restoreLastBackup.
	self assert: (db spData instVarNamed: #name) equals: 'me'.
	
	[ SpTestDatabase 
		defineMigration;
		dataVersion: 2.
	
	db reset; restoreLastBackup.
	
	self assert: (db spData instVarNamed: #name) class equals: SpDummyNameForTesting 
	]
		ensure: [ 
			SpTestDatabase 
				removeMigrationDefinition;
				dataVersion: 1 ].
]

{ #category : #accessing }
SimplePersistenceTests >> testSaveObjects [

	| db objectToStore anotherObjectToStore |
	db := SpTestDatabase.
	objectToStore := 1.
	anotherObjectToStore := 'you can persist any object, not just numbers and strings!'.
	
	db spData: { objectToStore. anotherObjectToStore }.
	db saveRepository.
	
	db reset.
	db restoreLastBackup.
	
	self assert: db spData first equals: objectToStore.
	self assert: db spData second equals: anotherObjectToStore.
]

{ #category : #accessing }
SimplePersistenceTests >> testSaveObjectsInBackground [

	| db objectToStore anotherObjectToStore |
	db := SpTestDatabase.
	objectToStore := 1.
	anotherObjectToStore := 'you can persist any object, not just numbers and strings!'.
	
	db spData: { objectToStore. anotherObjectToStore }.
	db takeSnapshot.
	
	db reset.
	db restoreLastBackup.
	
	self assert: db spData first equals: objectToStore.
	self assert: db spData second equals: anotherObjectToStore.
]
