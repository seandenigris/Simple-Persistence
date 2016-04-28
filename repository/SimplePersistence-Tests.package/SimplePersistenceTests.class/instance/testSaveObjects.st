as yet unclassified
testSaveObjects

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