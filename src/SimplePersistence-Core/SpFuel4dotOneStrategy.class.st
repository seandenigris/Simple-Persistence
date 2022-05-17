Class {
	#name : #SpFuel4dotOneStrategy,
	#superclass : #SpFuel4Strategy,
	#category : #'SimplePersistence-Core-Core'
}

{ #category : #testing }
SpFuel4dotOneStrategy class >> isActive [
	| currentFuel versionClass |
	
	versionClass := Smalltalk globals at: #FLVersion ifAbsent: [ ^ false ].
	currentFuel := versionClass current.
	^ currentFuel major > 4 or: [ currentFuel major = 4 and: [ currentFuel minor >= 1 ] ]
]

{ #category : #protocol }
SpFuel4dotOneStrategy >> materializeFrom: aFileReference [

	| materialization |
	materialization := FLMaterializer new
		filePath: aFileReference fullName;
		materialize.
		
	^ materialization root
]

{ #category : #accessing }
SpFuel4dotOneStrategy >> new: anFlClass withFile: aFileReference [
	^ anFlClass new
		filePath: aFileReference fullName;
		yourself.
]

{ #category : #protocol }
SpFuel4dotOneStrategy >> serialize: anObject to: aFileReference [

	FLSerializer new
		object: anObject;
		filePath: aFileReference fullName;
		serialize.
]
