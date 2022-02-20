"
Uses Fuel: An open-source* general-purpose object serialization framework developed in Pharo Smalltalk environment.

See http://rmod.lille.inria.fr/web/pier/software/Fuel for more details.

* Developed under the MIT license.
"
Class {
	#name : #SpFuel3Strategy,
	#superclass : #SpStrategy,
	#category : #'SimplePersistence-Core-Core'
}

{ #category : #testing }
SpFuel3Strategy class >> isActive [
	
	(FLSerializer respondsTo: #currentVersion) ifFalse: [ ^ false ].
	^ FLSerializer currentVersion asString first = $3
]

{ #category : #protocol }
SpFuel3Strategy >> materializeFrom: aFileReference [

	^ FLMaterializer materializeFromFileNamed: aFileReference fullName.
]

{ #category : #protocol }
SpFuel3Strategy >> serialize: anObject to: aFileReference [

	FLSerializer serialize: anObject toFileNamed: aFileReference fullName.
]
