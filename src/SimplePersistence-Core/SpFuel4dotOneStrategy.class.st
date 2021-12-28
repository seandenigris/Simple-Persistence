Class {
	#name : #SpFuel4dotOneStrategy,
	#superclass : #SpStrategy,
	#category : #'SimplePersistence-Core-Core'
}

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
