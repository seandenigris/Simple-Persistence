Class {
	#name : #SpFuel4Strategy,
	#superclass : #SpStrategy,
	#category : #'SimplePersistence-Core-Core'
}

{ #category : #protocol }
SpFuel4Strategy >> materializeFrom: aFileReference [

	| materialization |
	materialization := FLMaterializer new
		fileName: aFileReference fullName;
		materialize.
		
	^ materialization root
]

{ #category : #protocol }
SpFuel4Strategy >> serialize: anObject to: aFileReference [

	FLSerializer new
		object: anObject;
		fileName: aFileReference fullName;
		serialize.
]
