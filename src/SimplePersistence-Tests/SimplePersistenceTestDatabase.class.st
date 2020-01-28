Class {
	#name : #SimplePersistenceTestDatabase,
	#superclass : #SpFileDatabase,
	#classInstVars : [
		'number',
		'string'
	],
	#category : 'SimplePersistence-Tests'
}

{ #category : #accessing }
SimplePersistenceTestDatabase class >> number [

	^ number.
]

{ #category : #'as yet unclassified' }
SimplePersistenceTestDatabase class >> repositories [

	^ { number. string }
]

{ #category : #'as yet unclassified' }
SimplePersistenceTestDatabase class >> reset [

	number := string := nil.
]

{ #category : #'as yet unclassified' }
SimplePersistenceTestDatabase class >> restoreRepositories: someRepositories [

	number := someRepositories at: 1.
	string := someRepositories at: 2.
]

{ #category : #'as yet unclassified' }
SimplePersistenceTestDatabase class >> store: aNumber and: aString [

	number := aNumber.
	string := aString.
]

{ #category : #accessing }
SimplePersistenceTestDatabase class >> string [

	^ string.
]
