Class {
	#name : #SimplePersistenceModel,
	#superclass : #Object,
	#instVars : [
		'number',
		'string'
	],
	#classVars : [
		'default'
	],
	#category : #'SimplePersistence-Tests'
}

{ #category : #'instance creation' }
SimplePersistenceModel class >> default [ 
	^default ifNil: [ default := self new ]
]

{ #category : #'simple-persistence' }
SimplePersistenceModel class >> restoreFrom: aCollection [

	default := aCollection first
]

{ #category : #'simple-persistence' }
SimplePersistenceModel class >> spData [
	^{ self default }
]

{ #category : #accessing }
SimplePersistenceModel >> number [

	^ number.
]

{ #category : #storing }
SimplePersistenceModel >> reset [

	number := string := nil.
]

{ #category : #storing }
SimplePersistenceModel >> store: aNumber and: aString [

	number := aNumber.
	string := aString.
]

{ #category : #accessing }
SimplePersistenceModel >> string [

	^ string.
]
