Class {
	#name : #SpFuel5dotTwoStrategy,
	#superclass : #SpFuel4Strategy,
	#instVars : [
		'additionalObjects'
	],
	#category : #'SimplePersistence-Core-Core'
}

{ #category : #testing }
SpFuel5dotTwoStrategy class >> isActive [
	| currentFuel versionClass |
	
	versionClass := Smalltalk globals at: #FLVersion ifAbsent: [ ^ false ].
	currentFuel := versionClass current.
	^ currentFuel major > 5 or: [ currentFuel major = 5 and: [ currentFuel minor >= 2 ] ]
]

{ #category : #accessing }
SpFuel5dotTwoStrategy >> materialize: anSpBackup withMigrations: aCollection [
	| materialization materializer |
	materializer := self new: FLMaterializer withFile: anSpBackup file.
	
	aCollection do: [ :migration | 
		migration classNameChanges keysAndValuesDo: [ :source :target |
			materializer
				migrateClassNamed: source
				toClass: target asClass ] ].
	
	materialization := materializer materialize.

	anSpBackup
		header: materialization header spAdditionalObjects;
		spData: materialization root;
		file: anSpBackup file
]

{ #category : #accessing }
SpFuel5dotTwoStrategy >> materializeHeaderFrom: aFileReference [

	^ (self new: FLMaterializer withFile: aFileReference) materializeHeader spAdditionalObjects
]

{ #category : #accessing }
SpFuel5dotTwoStrategy >> new: anFlClass withFile: aFileReference [
	^ anFlClass new
		filePath: aFileReference fullName;
		yourself.
]
