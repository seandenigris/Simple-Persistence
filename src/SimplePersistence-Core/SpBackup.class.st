Class {
	#name : #SpBackup,
	#superclass : #Object,
	#instVars : [
		'header',
		'spData'
	],
	#category : #'SimplePersistence-Core-Core'
}

{ #category : #accessing }
SpBackup class >> newForDatabase: anSpFileDatabase [

	^ self new
		header: anSpFileDatabase metadata;
		spData: anSpFileDatabase spData;
		yourself
]

{ #category : #accessing }
SpBackup >> header [
	^ header ifNil: [ Dictionary new ]
]

{ #category : #accessing }
SpBackup >> header: anObject [
	header := anObject
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
