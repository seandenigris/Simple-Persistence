Class {
	#name : #SpDummyClassForTesting,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'SimplePersistence-Tests'
}

{ #category : #accessing }
SpDummyClassForTesting class >> renameInstVarName [

	self 
		removeInstVarNamed: #name;
		addInstVarNamed: #nameObject.
]

{ #category : #accessing }
SpDummyClassForTesting class >> undoRenameInstVarName [

	self 
		removeInstVarNamed: #nameObject;
		addInstVarNamed: #name.
]
