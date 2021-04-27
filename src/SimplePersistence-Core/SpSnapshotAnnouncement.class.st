Class {
	#name : #SpSnapshotAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'version',
		'name'
	],
	#category : #'SimplePersistence-Core-Core'
}

{ #category : #versions }
SpSnapshotAnnouncement class >> version: aNumber name: aString [
	^self new 
		version: aNumber;
		name: aString;
		yourself
]

{ #category : #accessing }
SpSnapshotAnnouncement >> name [
	^ name
]

{ #category : #accessing }
SpSnapshotAnnouncement >> name: anObject [
	name := anObject
]

{ #category : #accessing }
SpSnapshotAnnouncement >> version [
	^ version
]

{ #category : #accessing }
SpSnapshotAnnouncement >> version: anObject [
	version := anObject
]
