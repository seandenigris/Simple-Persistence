Class {
	#name : #SpBackup,
	#superclass : #Object,
	#instVars : [
		'header',
		'spData',
		'file',
		'database'
	],
	#category : #'SimplePersistence-Core-Core'
}

{ #category : #accessing }
SpBackup class >> newForDatabase: anSpFileDatabase [

	^ self new
		database: anSpFileDatabase;
		yourself
]

{ #category : #accessing }
SpBackup >> database [
	^ database
]

{ #category : #accessing }
SpBackup >> database: anObject [
	database := anObject
]

{ #category : #accessing }
SpBackup >> file [
	^ file
]

{ #category : #accessing }
SpBackup >> file: anObject [
	file := anObject
]

{ #category : #accessing }
SpBackup >> header [
	header ifNotNil: [ ^ header ].
	
	self file ifExists: [
		^ header := self database serializer materializeHeaderFrom: self file ].
	
	^ header := Dictionary new
]

{ #category : #accessing }
SpBackup >> header: anObject [
	header := anObject
]

{ #category : #accessing }
SpBackup >> printOn: aStream [

	aStream nextPutAll: self version asString
]

{ #category : #accessing }
SpBackup >> restore [

	"All client classes (i.e. that use me for persistence) must respond to this message. The argument (here aDictionary, but could be any type) is the data they gave me to persist"
	self spData keysAndValuesDo: [ :klass :data | klass restoreFrom: data ]
]

{ #category : #accessing }
SpBackup >> spData [
	^ spData
]

{ #category : #accessing }
SpBackup >> spData: anObject [
	spData := anObject
]

{ #category : #accessing }
SpBackup >> version [
	^ self file extension asInteger.
]
