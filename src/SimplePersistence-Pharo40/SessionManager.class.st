Class {
	#name : #SessionManager,
	#superclass : #Object,
	#category : 'SimplePersistence-Pharo40'
}

{ #category : #'as yet unclassified' }
SessionManager class >> default [
	^ self new
]

{ #category : #'as yet unclassified' }
SessionManager >> registerUserClassNamed: aString [ 
	
	| class |
	class := Smalltalk classNamed: aString.
	Smalltalk
		addToStartUpList: class;
		addToShutDownList: class
]

{ #category : #'as yet unclassified' }
SessionManager >> unregisterClassNamed: aString [ 

	| class |
	class := Smalltalk classNamed: aString.
	Smalltalk
		removeFromStartUpList: class;
		removeFromShutDownList: class
]
