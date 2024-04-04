Class {
	#name : #SimplePersistenceTests,
	#superclass : #TestCase,
	#category : #'SimplePersistence-Tests'
}

{ #category : #'tests-core' }
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

{ #category : #'tests-extensions' }
SimplePersistenceTests >> testFileLocatorStoreOn [
	| original recipe clone |
	original := FileLocator home / 'subfolder'.
	recipe := String streamContents: [ :s | original storeOn: s ].
	clone := Smalltalk compiler evaluate: recipe.
	self assert: original equals: clone
]

{ #category : #'tests-extensions' }
SimplePersistenceTests >> testFileReferenceStoreOn [
	| original recipe clone |
	original := 'root/sub1/sub2' asFileReference.
	recipe := String streamContents: [ :s | original storeOn: s ].
	clone := Smalltalk compiler evaluate: recipe.
	self assert: original equals: clone
]

{ #category : #'tests-core' }
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

{ #category : #'tests-core' }
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
