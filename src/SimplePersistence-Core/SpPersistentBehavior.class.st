Class {
	#name : 'SpPersistentBehavior',
	#superclass : 'Object',
	#instVars : [
		'subjectClass',
		'variableName',
		'targetClass'
	],
	#category : 'SimplePersistence-Core-Developer'
}

{ #category : 'convenience' }
SpPersistentBehavior class >> addTo: aClass for: aSymbol [
	^ self new
		targetClass: aClass;
		variableName: aSymbol;
		add
]

{ #category : 'API' }
SpPersistentBehavior >> add [
	| methodsExist |
	methodsExist := #(spData restoreFrom:)
		anySatisfy: [ :sel | self targetClass class includesLocalSelector: sel ].
	methodsExist ifTrue: [ self error: 'Boilerplate can only be added for first variable for a class. After that you must edit the methods manually' ].
	self addGetter.
	self addSetter
]

{ #category : 'private' }
SpPersistentBehavior >> addGetter [
	self addMethodFromTemplate: 'spData

	^ {1}.'
]

{ #category : 'private' }
SpPersistentBehavior >> addMethodFromTemplate: template [
	| source |
	source := template format: { self variableName }.
	self targetClass class compile: source classified: 'persistence'
]

{ #category : 'private' }
SpPersistentBehavior >> addSetter [

	self addMethodFromTemplate: 'restoreFrom: anObject

	{1} := anObject.'
]

{ #category : 'accessing' }
SpPersistentBehavior >> targetClass [
	^ targetClass
]

{ #category : 'accessing' }
SpPersistentBehavior >> targetClass: aClass [
	targetClass := aClass
]

{ #category : 'accessing' }
SpPersistentBehavior >> variableName [
	^ variableName
]

{ #category : 'accessing' }
SpPersistentBehavior >> variableName: aSymbol [
	variableName := aSymbol
]
