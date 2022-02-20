Class {
	#name : #SpFuel4dotOneStrategy,
	#superclass : #SpStrategy,
	#category : #'SimplePersistence-Core-Core'
}

{ #category : #testing }
SpFuel4dotOneStrategy class >> isActive [
	| currentFuel versionClass |
	versionClass := Smalltalk globals at: #FLVersion ifAbsent: [ ^ false ].
	currentFuel := versionClass current.
	^ currentFuel major = 4 and: [ currentFuel minor = 1 ]
]

{ #category : #protocol }
SpFuel4dotOneStrategy >> materializeFrom: aFileReference [

	| materialization |
	materialization := FLMaterializer new
		filePath: aFileReference fullName;
		materialize.
		
	^ materialization root
]

{ #category : #protocol }
SpFuel4dotOneStrategy >> serialize: anObject to: aFileReference [

	FLSerializer new
		object: anObject;
		filePath: aFileReference fullName;
		serialize.
]
