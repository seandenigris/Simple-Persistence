Class {
	#name : #SpTestDatabase,
	#superclass : #SpFileDatabase,
	#classInstVars : [
		'data',
		'dataVersion'
	],
	#category : #'SimplePersistence-Tests'
}

{ #category : #accessing }
SpTestDatabase class >> backupDirectoryParent [
	^ FileLocator temp
]

{ #category : #accessing }
SpTestDatabase class >> dataVersion [
	^ dataVersion ifNil: [ 1 ]
]

{ #category : #accessing }
SpTestDatabase class >> dataVersion: anObject [
	dataVersion := anObject
]

{ #category : #accessing }
SpTestDatabase class >> defineMigration [

	self migrationPragmaDo: [ :tree :pragma | tree addPragma: pragma ]
]

{ #category : #accessing }
SpTestDatabase class >> migrationPragmaDo: aBlock [
	| methodTree pragmaNode |
	methodTree := (self class >> #version2Migration) parseTree.
	pragmaNode := RBPragmaNode selector: #dataMigration arguments: #().
	aBlock value: methodTree value: pragmaNode.
	^ self class compile: methodTree newSource classified: 'migrations'
]

{ #category : #accessing }
SpTestDatabase class >> removeMigrationDefinition [

	self migrationPragmaDo: [ :tree :pragma | tree removePragma: pragma ]
]

{ #category : #accessing }
SpTestDatabase class >> reset [

	data := nil.
]

{ #category : #accessing }
SpTestDatabase class >> restoreFrom: anObject [

	data := anObject
]

{ #category : #accessing }
SpTestDatabase class >> spData [

	^ data
]

{ #category : #accessing }
SpTestDatabase class >> spData: anObject [

	data := anObject
]

{ #category : #migrations }
SpTestDatabase class >> version2Migration [
	^ SpDataMigration new
		dataVersion: 2;
		postMaterialize: [ SpDummyClassForTesting
				allSubInstancesDo: [ :inst | 
					| nameObject nameString |
					nameString := inst instVarNamed: #name.
					nameObject := SpDummyNameForTesting named: nameString.
					inst instVarNamed: #name put: nameObject ] ]
]
