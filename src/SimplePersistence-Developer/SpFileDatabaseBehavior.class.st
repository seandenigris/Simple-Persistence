Class {
	#name : #SpFileDatabaseBehavior,
	#superclass : #Object,
	#instVars : [
		'containerClass',
		'instVarName',
		'databaseClass'
	],
	#category : #'SimplePersistence-Developer'
}

{ #category : #'setting up' }
SpFileDatabaseBehavior class >> createFor: aClass persisting: aSymbol [ 

	| instance |
	instance := self new
			containerClass: aClass;
			instVarName: aSymbol.
	^ instance create.
]

{ #category : #'setting up' }
SpFileDatabaseBehavior >> addBackupDirectoryHook [

	| source |
	source := 
'backupDirectoryParent
	"Re-write this if you''d like your backups to be saved in a location other than the image folder"
	^ super backupDirectoryParent'.
	self databaseClass class compile: source classified: 'accessing'.
]

{ #category : #private }
SpFileDatabaseBehavior >> containerClass: aClass [

	containerClass := aClass.
]

{ #category : #API }
SpFileDatabaseBehavior >> create [

	self 
		addBackupDirectoryHook;
		updateSchema.
]

{ #category : #'setting up' }
SpFileDatabaseBehavior >> databaseClass [
	
	| topLevelCategory dbClassName |
	databaseClass ifNil: [
		topLevelCategory := containerClass category copyUpTo: $-.
		dbClassName := (topLevelCategory, 'DB') asSymbol.
		databaseClass := SpFileDatabase subclass: dbClassName
		instanceVariableNames: ''
		classVariableNames: ''
		poolDictionaries: ''
		category: topLevelCategory, '-Persistence' ].
	
	^ databaseClass.
]

{ #category : #'setting up' }
SpFileDatabaseBehavior >> databaseClass: aClass [
	
	databaseClass := aClass
]

{ #category : #private }
SpFileDatabaseBehavior >> instVarName: aSymbol [

	instVarName := aSymbol.
]

{ #category : #'setting up' }
SpFileDatabaseBehavior >> updateSchema [

	| source classes sortedClasses |
	classes := Set with: containerClass.
	(databaseClass class includesLocalSelector: #schema) ifTrue: [ classes addAll: databaseClass schema ].
	sortedClasses := classes asSortedCollection: [ :a :b | a name < b name ].
	source := String streamContents: [ :str |
		str 
			nextPutAll: 'schema'; cr; cr;
			tab; nextPutAll: '^ {'; cr.
		sortedClasses do: [ :c | str tab; tab; tab; nextPutAll: c name; nextPut: $.; cr ].
		str tab; tab; nextPutAll: '}.'. ].
	self databaseClass class compile: source classified: 'loading/saving'.
]
