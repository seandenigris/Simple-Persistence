Class {
	#name : #SpPersistentBehavior,
	#superclass : #Object,
	#classInstVars : [
		'persistedClass',
		'persistedInstance'
	],
	#category : 'SimplePersistence-Core-Developer'
}

{ #category : #'as yet unclassified' }
SpPersistentBehavior class >> addTo: aClass for: aSymbol [ 

	^ self new addTo: aClass for: aSymbol.
]

{ #category : #'as yet unclassified' }
SpPersistentBehavior >> addTo: aClass for: aSymbol [ 

	| template source |
	template := 
'restoreFrom: anObject

	{1} := anObject.'.
	source := template format: { aSymbol }.
	aClass class compile: source classified: 'persistence'.
]
