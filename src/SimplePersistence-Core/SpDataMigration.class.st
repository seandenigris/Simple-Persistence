Class {
	#name : #SpDataMigration,
	#superclass : #Object,
	#instVars : [
		'dataVersion',
		'preMaterialize',
		'postMaterialize'
	],
	#category : #'SimplePersistence-Core'
}

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
