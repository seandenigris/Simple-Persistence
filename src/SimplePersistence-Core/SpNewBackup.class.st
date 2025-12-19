Class {
	#name : 'SpNewBackup',
	#superclass : 'SpBackup',
	#category : 'SimplePersistence-Core-Core',
	#package : 'SimplePersistence-Core',
	#tag : 'Core'
}

{ #category : 'accessing' }
SpNewBackup class >> newForDatabase: anSpFileDatabase [

	^ self new
		database: anSpFileDatabase;
		header: anSpFileDatabase metadata;
		spData: anSpFileDatabase spData;
		yourself
]

{ #category : 'accessing' }
SpNewBackup >> spData [
	^ spData
]
