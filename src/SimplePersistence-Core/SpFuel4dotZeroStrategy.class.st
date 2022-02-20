Class {
	#name : #SpFuel4dotZeroStrategy,
	#superclass : #SpStrategy,
	#category : #'SimplePersistence-Core-Core'
}

{ #category : #testing }
SpFuel4dotZeroStrategy class >> isActive [
	| currentFuel versionClass |
	versionClass := Smalltalk globals at: #FLVersion ifAbsent: [ ^ false ].
	currentFuel := versionClass current.
	^ currentFuel major = 4 and: [ currentFuel minor = 0 ]
]

{ #category : #protocol }
SpFuel4dotZeroStrategy >> materializeFrom: aFileReference [

	| materialization |
	materialization := FLMaterializer new
		fileName: aFileReference fullName;
		materialize.
		
	^ materialization root
]

{ #category : #protocol }
SpFuel4dotZeroStrategy >> serialize: anObject to: aFileReference [

	FLSerializer new
		object: anObject;
		fileName: aFileReference fullName;
		serialize.
]
