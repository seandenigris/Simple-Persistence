Class {
	#name : #SimplePersistenceTestDatabase,
	#superclass : #SpFileDatabase,
	#classVars : [
		'model'
	],
	#category : #'SimplePersistence-Tests'
}

{ #category : #'default model values' }
SimplePersistenceTestDatabase class >> model [ 
	
	^SimplePersistenceModel default
]

{ #category : #api }
SimplePersistenceTestDatabase class >> schema [

	^ { SimplePersistenceModel }
]
