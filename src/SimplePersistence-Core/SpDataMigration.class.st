Class {
	#name : #SpDataMigration,
	#superclass : #Object,
	#instVars : [
		'dataVersion',
		'preMaterialize',
		'postMaterialize',
		'classNameChanges'
	],
	#category : #'SimplePersistence-Core-Core'
}

{ #category : #accessing }
SpDataMigration >> classNameChanges [
	^ classNameChanges ifNil: [ #() ]
]

{ #category : #accessing }
SpDataMigration >> classNameChanges: aCollection [
	classNameChanges := aCollection asDictionary
]

{ #category : #accessing }
SpDataMigration >> dataVersion [
	^ dataVersion
]

{ #category : #accessing }
SpDataMigration >> dataVersion: anObject [
	dataVersion := anObject
]

{ #category : #accessing }
SpDataMigration >> postMaterialize [
	^ postMaterialize
]

{ #category : #accessing }
SpDataMigration >> postMaterialize: anObject [
	postMaterialize := anObject
]

{ #category : #accessing }
SpDataMigration >> preMaterialize [
	^ preMaterialize
]

{ #category : #accessing }
SpDataMigration >> preMaterialize: anObject [
	preMaterialize := anObject
]
