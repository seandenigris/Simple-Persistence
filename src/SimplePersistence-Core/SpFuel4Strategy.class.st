Class {
	#name : #SpFuel4Strategy,
	#superclass : #SpStrategy,
	#category : #'SimplePersistence-Core-Core'
}

{ #category : #testing }
SpFuel4Strategy class >> isActive [
	"I am abstract"
	^ false
]

{ #category : #accessing }
SpFuel4Strategy >> materializeFrom: aFileReference [

	| materialization |
	materialization := (self new: FLMaterializer withFile: aFileReference) materialize.
		
	^ materialization root
]

{ #category : #accessing }
SpFuel4Strategy >> new: anFlClass withFile: aFileReference [
	self subclassResponsibility
]

{ #category : #protocol }
SpFuel4Strategy >> serialize: anObject withMetadata: aDictionary to: aFileReference [

	| serializer |
	serializer := self new: FLSerializer withFile: aFileReference.
		
	aDictionary keysAndValuesDo: [  :k :v |
		serializer at: k putAdditionalObject: v ].
	
	serializer 
		object: anObject;
		serialize.
]
