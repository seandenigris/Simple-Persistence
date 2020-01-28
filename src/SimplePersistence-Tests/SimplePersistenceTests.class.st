Class {
	#name : #SimplePersistenceTests,
	#superclass : #TestCase,
	#category : 'SimplePersistence-Tests'
}

{ #category : #'as yet unclassified' }
SimplePersistenceTests >> testSaveObjects [

	| db objectToStore anotherObjectToStore |
	db := SimplePersistenceTestDatabase.
	objectToStore := 1.
	anotherObjectToStore := 'you can persist any object, not just numbers and strings!'.
	
	db store: objectToStore and: anotherObjectToStore.
	db saveRepository.
	
	db reset.
	db restoreLastBackup.
	
	self assert: (db number = objectToStore).
	self assert: (db string = anotherObjectToStore).
]

{ #category : #'as yet unclassified' }
SimplePersistenceTests >> testSaveObjectsInBackground [

	| db objectToStore anotherObjectToStore |
	db := SimplePersistenceTestDatabase.
	objectToStore := 1.
	anotherObjectToStore := 'you can persist any object, not just numbers and strings!'.
	
	db store: objectToStore and: anotherObjectToStore.
	db takeSnapshot.
	
	db reset.
	db restoreLastBackup.
	
	self assert: (db number = objectToStore).
	self assert: (db string = anotherObjectToStore).
]
