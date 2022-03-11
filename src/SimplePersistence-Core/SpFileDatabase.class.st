"
Based on the idea that:
* most applications will not have to scale (i.e. become the next Twitter)
* simply saving the image is slow and error-prone

For the full motivation, see Ramon Leon's blog post at http://onsmalltalk.com/simple-image-based-persistence-in-squeak/.

To give your application persistence:
	1. Subclass SMFileDatabase
	2. On the subclass, implement:
		a. class>>repositories (see method comment).
		b. class>>restoreRepositories: (see method comment).
		
That's it! Now, whenever you want to save, call class>>saveRepository or class>>takeSnapshot (background save).

To customize:
* Number of backups kept: override class>>defaultHistoryCount

"
Class {
	#name : #SpFileDatabase,
	#superclass : #Object,
	#classVars : [
		'RootDataFolder',
		'SerializerClass'
	],
	#classInstVars : [
		'lock'
	],
	#category : #'SimplePersistence-Core-Core'
}

{ #category : #private }
SpFileDatabase class >> availableVersions [

	^ self backupFiles collect: [ :e | 
		self versionOf: e ].
]

{ #category : #restoring }
SpFileDatabase class >> backupBrowser [
	<script>
	
	| dbs |
	dbs := self subclasses.
	SpBackupBrowser openOn: dbs
]

{ #category : #accessing }
SpFileDatabase class >> backupDirectory [

	^ (self backupDirectoryParent / self backupDirectoryName) ensureCreateDirectory.
]

{ #category : #accessing }
SpFileDatabase class >> backupDirectoryName [

	^self name
]

{ #category : #accessing }
SpFileDatabase class >> backupDirectoryParent [
	^ self rootDataFolder
]

{ #category : #private }
SpFileDatabase class >> backupFileForVersion: aNumber [

	^ self backupFiles detect: [:each | (self versionOf: each) = aNumber ] ifNone: [ nil ].
]

{ #category : #private }
SpFileDatabase class >> backupFiles [

	^ self backupDirectory files select: [ :e | 
			(e basename beginsWith: self name) and: [ e extension isAllDigits ] ].
]

{ #category : #private }
SpFileDatabase class >> backupVersion: aNumber [
	| backup |
	backup := self backupFileForVersion: aNumber.
	backup ifNil: [ ^ nil ].
	^ self serializer materializeFrom: backup.
]

{ #category : #accessing }
SpFileDatabase class >> defaultHistoryCount [
	"How many backups to keep."
	^ 50
]

{ #category : #private }
SpFileDatabase class >> disablePersistence [
	SessionManager default unregisterClassNamed: self name
]

{ #category : #private }
SpFileDatabase class >> enablePersistence [
	SessionManager default registerUserClassNamed: self name
]

{ #category : #GToolkit }
SpFileDatabase class >> gtBasicFor: aView [
	<gtView>
	<gtClassView>
	self isAbstract ifTrue: [ ^ aView empty ].
	^ aView forward 
		title: 'Data';
		priority: -9;
		object: [ self spData ];
		view: #gtItemsFor:
]

{ #category : #accessing }
SpFileDatabase class >> isAbstract [
	^ self name = #SpFileDatabase
]

{ #category : #testing }
SpFileDatabase class >> isPersistenceEnabled [
	^ SessionManager default hasRegistered: self name
]

{ #category : #restoring }
SpFileDatabase class >> lastBackup [
	^ self backupVersion: self lastBackupVersion.
]

{ #category : #private }
SpFileDatabase class >> lastBackupVersion [

	| lastBackupFile |
	lastBackupFile := self backupFiles detectMax: [:each | self versionOf: each].
	^ lastBackupFile isNil
		ifTrue: [ 0 ]
		ifFalse: [ self versionOf: lastBackupFile ].
	
]

{ #category : #'*SimplePersistence-Core-Developer' }
SpFileDatabase class >> menuCommandOn: aBuilder [ 
	<worldMenu> 
	
	(aBuilder item: #'Simple Persistence')
		with: [
			(aBuilder item: #'Backup Browser')
				action: [ self backupBrowser ]; 
				icon: Smalltalk ui icons glamourousTable. ]
]

{ #category : #'*SimplePersistence-Core-Developer' }
SpFileDatabase class >> persist: aSymbol in: aClass [ 
	"See Object>>#persistIn:as:"

	SpFileDatabaseBehavior createFor: aClass persisting: aSymbol.
	SpPersistentBehavior addTo: aClass for: aSymbol.
]

{ #category : #accessing }
SpFileDatabase class >> projectName [
	^ self name allButLast: 2
]

{ #category : #restoring }
SpFileDatabase class >> restoreBackupVersion: aNumber [
	(self backupVersion: aNumber)
		ifNotNil: [ :backup | self restoreFrom: backup ]
]

{ #category : #restoring }
SpFileDatabase class >> restoreFrom: aDictionary [
	"All client classes (i.e. that use me for persistence) must respond to this message. The argument (here aDictionary, but could be any type) is the data they gave me to persist"
	aDictionary keysAndValuesDo: [ :klass :data | klass restoreFrom: data ]
]

{ #category : #restoring }
SpFileDatabase class >> restoreLastBackup [
	<script>
	self restoreBackupVersion: self lastBackupVersion.
]

{ #category : #accessing }
SpFileDatabase class >> rootDataFolder [
	^ RootDataFolder ifNil: [ FileLocator imageDirectory ]
]

{ #category : #accessing }
SpFileDatabase class >> rootDataFolder: anObject [
	RootDataFolder := anObject
]

{ #category : #saving }
SpFileDatabase class >> saveRepository [
	<script>
	| version backupName |
	lock ifNil: [ lock := Semaphore forMutualExclusion ].
	lock
		critical: [
			self trimBackups.
			version := self lastBackupVersion + 1.
			backupName := self backupDirectory / self name , version asString.
			self serializer serialize: self spData to: backupName.
		].
	
	SystemAnnouncer uniqueInstance announce: (SpSnapshotAnnouncement version: version name: backupName) 
]

{ #category : #accessing }
SpFileDatabase class >> schema [
	"Return aCollection of classes for which we will be handling persistence
		Example: `^ { QuQuote. LivingLibraryDB }`; where 
			- QuQuote is a domain class that is part of our project
			- LivingLibraryDB is the DB from another project (LivingLibraryDB sbclass), which we will take over and persist as part of our model."
			
	self subclassResponsibility
]

{ #category : #private }
SpFileDatabase class >> serializer [
	"See SpSerializer class comment"

	^ SerializerClass
		ifNil: [ SpStrategy default ]
		ifNotNil: [ :cls | cls new ].
]

{ #category : #accessing }
SpFileDatabase class >> serializerClass: anSpFuelSerializerClass [
	SerializerClass := anSpFuelSerializerClass
]

{ #category : #private }
SpFileDatabase class >> setUp [
	self restoreLastBackup.
	self enablePersistence
]

{ #category : #'system startup' }
SpFileDatabase class >> shutDown: isGoingDown [ 
	isGoingDown ifTrue: [ self saveRepository ]
]

{ #category : #accessing }
SpFileDatabase class >> spData [
	"All client classes (i.e. that use me for persistence) must respond to this message with the data to be persisted. Multiple DBs in the tree may include the same object without increasing the size on disk. Fuel is smart enough i.e. only saves each object once even if there are multiple references to it in the graph."
	^ self schema
		inject: Dictionary new
		into: [ :dict :klass | dict at: klass put: klass spData; yourself ]
]

{ #category : #'system startup' }
SpFileDatabase class >> startUp: isComingUp [ 
	isComingUp ifTrue: [ self restoreLastBackup ]
]

{ #category : #saving }
SpFileDatabase class >> takeSnapshot [
	"Motivation (vs. #saveRepository) - if you want a little extra snappiness and you're not worried about making the user wait for the flush to disk"
	[self saveRepository] forkAt: Processor userBackgroundPriority
		named: 'snapshot: ' , self class name
]

{ #category : #private }
SpFileDatabase class >> togglePersistence [
	self isPersistenceEnabled
		ifTrue: [ self disablePersistence ]
		ifFalse: [ self enablePersistence ]
]

{ #category : #private }
SpFileDatabase class >> trimBackups [
	| entries versionsToKeep |
	versionsToKeep := self defaultHistoryCount.
	entries := self backupFiles select: [ :e | e base = self name ].
	entries size < versionsToKeep ifTrue: [ ^ self ].
	((entries sort: [ :a :b | a extension asInteger < b extension asInteger ]) allButLast: versionsToKeep) 
		do: [ :entry | entry delete ].
]

{ #category : #private }
SpFileDatabase class >> versionOf: backupFile [
	^ backupFile extension asInteger.
]

{ #category : #viewing }
SpFileDatabase class >> viewBackupDirectory [
	self backupDirectory peOpen
]
