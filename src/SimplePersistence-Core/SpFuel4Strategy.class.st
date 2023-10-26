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
SpFuel4Strategy >> materialize: anSpBackup withMigrations: aCollection [
	| materialization materializer |
	materializer := self new: FLMaterializer withFile: anSpBackup file.
	
	aCollection do: [ :migration | 
		migration classNameChanges keysAndValuesDo: [ :source :target |
			materializer
				migrateClassNamed: source
				toClass: target asClass ] ].
	
	materialization := materializer materialize.

	anSpBackup
		header: materialization header additionalObjects;
		spData: materialization root;
		file: anSpBackup file
]

{ #category : #accessing }
SpFuel4Strategy >> materializeHeaderFrom: aFileReference [

	^ (self new: FLMaterializer withFile: aFileReference) materializeHeader additionalObjects
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
