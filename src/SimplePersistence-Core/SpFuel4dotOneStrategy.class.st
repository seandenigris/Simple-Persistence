Class {
	#name : #SpFuel4dotOneStrategy,
	#superclass : #SpFuel4Strategy,
	#instVars : [
		'additionalObjects'
	],
	#category : #'SimplePersistence-Core-Core'
}

{ #category : #testing }
SpFuel4dotOneStrategy class >> isActive [
	| currentFuel versionClass |
	
	versionClass := Smalltalk globals at: #FLVersion ifAbsent: [ ^ false ].
	currentFuel := versionClass current.
	^ currentFuel major > 4 or: [ currentFuel major = 4 and: [ currentFuel minor >= 1 ] ]
]

{ #category : #accessing }
SpFuel4dotOneStrategy >> new: anFlClass withFile: aFileReference [
	^ anFlClass new
		filePath: aFileReference fullName;
		yourself.
]
