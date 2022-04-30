"
Uses Fuel: An open-source* general-purpose object serialization framework developed in Pharo Smalltalk environment.

See http://rmod.lille.inria.fr/web/pier/software/Fuel for more details.

* Developed under the MIT license.
"
Class {
	#name : #SpFuelPreV4Strategy,
	#superclass : #SpStrategy,
	#category : #'SimplePersistence-Core-Core'
}

{ #category : #testing }
SpFuelPreV4Strategy class >> isActive [
	
	^ FLSerializer respondsTo: #currentVersion
]

{ #category : #protocol }
SpFuelPreV4Strategy >> materializeFrom: aFileReference [

	^ FLMaterializer materializeFromFileNamed: aFileReference fullName.
]

{ #category : #protocol }
SpFuelPreV4Strategy >> serialize: anObject to: aFileReference [

	FLSerializer serialize: anObject toFileNamed: aFileReference fullName.
]
