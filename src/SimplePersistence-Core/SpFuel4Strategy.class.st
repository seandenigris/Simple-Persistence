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
		
	^ SpBackup new
		header: materialization header additionalObjects;
		spData: materialization root;
		yourself
]

{ #category : #accessing }
SpFuel4Strategy >> new: anFlClass withFile: aFileReference [
	self subclassResponsibility
]

{ #category : #protocol }
SpFuel4Strategy >> serialize: anSpBackup to: aFileReference [

	| serializer |
	serializer := self new: FLSerializer withFile: aFileReference.
		
	anSpBackup header keysAndValuesDo: [ :k :v |
		serializer at: k putAdditionalObject: v ].
		
	serializer 
		object: anSpBackup spData;
		serialize
]
