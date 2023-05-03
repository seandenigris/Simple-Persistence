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
SpFuelPreV4Strategy >> materialize: anSpBackup from: aFileReference [

	| root |
	root := FLMaterializer materializeFromFileNamed: aFileReference fullName.
	
	anSpBackup
		spData: root;
		file: aFileReference
]

{ #category : #protocol }
SpFuelPreV4Strategy >> materializeHeaderFrom: aFileReference [

	^ Dictionary new
]

{ #category : #protocol }
SpFuelPreV4Strategy >> serialize: anSpBackup to: aFileReference [

	FLSerializer 
		serialize: anSpBackup spData 
		toFileNamed: aFileReference fullName.
]
