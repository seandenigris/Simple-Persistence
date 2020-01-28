Class {
	#name : #SpFileDatabaseBehavior,
	#superclass : #Object,
	#instVars : [
		'containerClass',
		'instVarName',
		'databaseClass'
	],
	#category : 'SimplePersistence-Core-Developer'
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

{ #category : #'setting up' }
SpFileDatabaseBehavior >> addInitializer [
	"Call on subclasses to add class initialization"

	self databaseClass class compile:
'initialize
	self setUp.' classified: 'class initialization'.
]

{ #category : #'setting up' }
SpFileDatabaseBehavior >> addRepositoryAccessorFor: aSymbol of: aClass [ 

	| template source |
	template := 
'repositories

	^ \{ {1} {2} \}.'.
	source := template format: { aClass name. aSymbol }.
	self databaseClass class compile: source classified: 'loading/saving'.
]

{ #category : #'setting up' }
SpFileDatabaseBehavior >> addRestorationMethodFor: aClass [ 

	| template source |
	template := 
'restoreRepositories: someRepositories

	{1} restoreFrom: someRepositories first.'.
	source := template format: { aClass name }.
	self databaseClass class compile: source classified: 'loading/saving'.
]

{ #category : #'setting up' }
SpFileDatabaseBehavior >> addRestoreScript [

	| source |
	source := 
'restoreLastBackup
	<script>
	^ super restoreLastBackup'.
	self databaseClass class compile: source classified: 'loading/saving'.
]

{ #category : #'setting up' }
SpFileDatabaseBehavior >> addRootDataFolder [

	| sourceTemplate source |
	sourceTemplate := 'rootDataFolder
	^ {fileReference}'.
	source := sourceTemplate format: { #fileReference -> self rootDataFolderRecipe } asDictionary.
	self databaseClass class compile: source classified: 'accessing'.
]

{ #category : #'setting up' }
SpFileDatabaseBehavior >> addSaveScript [

	| source |
	source := 
'saveRepository
	<script>
	^ super saveRepository'.
	self databaseClass class compile: source classified: 'loading/saving'.
]

{ #category : #private }
SpFileDatabaseBehavior >> containerClass: aClass [

	containerClass := aClass.
]

{ #category : #API }
SpFileDatabaseBehavior >> create [

	self
		addInitializer;
		addRepositoryAccessorFor: instVarName of: containerClass;
		addRestorationMethodFor: containerClass;
		addBackupDirectoryHook;
		addSaveScript;
		addRestoreScript.
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

{ #category : #private }
SpFileDatabaseBehavior >> rootDataFolderRecipe [
	^ String streamContents: [:s | SpFileDatabase rootDataFolder storeOn: s ]
]
