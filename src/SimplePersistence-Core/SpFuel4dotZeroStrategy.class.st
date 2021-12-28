Class {
	#name : #SpFuel4dotZeroStrategy,
	#superclass : #SpStrategy,
	#category : #'SimplePersistence-Core-Core'
}

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
