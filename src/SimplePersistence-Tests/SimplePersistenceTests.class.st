Class {
	#name : #SimplePersistenceTests,
	#superclass : #TestCase,
	#category : #'SimplePersistence-Tests'
}

{ #category : #'as yet unclassified' }
SimplePersistenceTests >> testSaveObjects [

	| db objectToStore anotherObjectToStore |
	db := SimplePersistenceTestDatabase.
	objectToStore := Random new nextInt: 10.
	anotherObjectToStore := 'you can persist any object, not just numbers and strings!'.
	
	db model store: objectToStore and: anotherObjectToStore.
	db saveRepository.
	
	db model reset.
	db restoreLastBackup.
	
	self assert: db model number equals: objectToStore.
	self assert: db model string equals: anotherObjectToStore.
]

{ #category : #'as yet unclassified' }
SimplePersistenceTests >> testSaveObjectsInBackground [
	| db objectToStore anotherObjectToStore sem |
	
	db := SimplePersistenceTestDatabase.
	objectToStore := -1.
	anotherObjectToStore := 'you can persist any object, not just numbers and strings!'.
	
	db model store: objectToStore and: anotherObjectToStore.
	
	sem := Semaphore new.
	SystemAnnouncer uniqueInstance when: SpSnapshotAnnouncement do: [ :ann | sem signal ].
	
	db takeSnapshot.
		
	sem waitTimeoutSeconds: 5 onCompletion: [ #completed ] onTimeout: [ self assert: false description: 'snapshot timed out' ].
	
	db model reset.
	db restoreLastBackup.
	
	self assert: db model number equals: objectToStore.
	self assert: db model string equals: anotherObjectToStore 
]
