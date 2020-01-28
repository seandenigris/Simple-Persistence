"
Uses Fuel: An open-source* general-purpose object serialization framework developed in Pharo Smalltalk environment.

See http://rmod.lille.inria.fr/web/pier/software/Fuel for more details.

* Developed under the MIT license.
"
Class {
	#name : #SpFuelSerializer,
	#superclass : #SpSerializer,
	#category : 'SimplePersistence-Core'
}

{ #category : #protocol }
SpFuelSerializer >> materializeFrom: aFileReference [

	^ FLMaterializer materializeFromFileNamed: aFileReference fullName.
]

{ #category : #protocol }
SpFuelSerializer >> serialize: anObject to: aFileReference [

	FLSerializer serialize: anObject toFileNamed: aFileReference fullName.
]
