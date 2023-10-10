Class {
	#name : #SpDummyNameForTesting,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'SimplePersistence-Tests'
}

{ #category : #migrations }
SpDummyNameForTesting class >> named: aString [ 

	^ self new
		name: aString;
		yourself
]

{ #category : #accessing }
SpDummyNameForTesting >> name [
	^ name
]

{ #category : #accessing }
SpDummyNameForTesting >> name: anObject [
	name := anObject
]
