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
SpFileDatabase class >> availableBackups [

	| backups |
	backups := self backupFiles collect: [ :e | 
		(SpBackup newForDatabase:  self)
			file: e;
			yourself ].
			
	^ backups asSortedCollection: #version descending
]

{ #category : #GToolkit }
SpFileDatabase class >> availableBackupsGtViewFor: aView [
	<gtView>
	
	| list |
	list := aView columnedList
		title: 'Backups';
		priority: -5;
		items: [ self availableBackups sort: #version descending ];
		column: 'Version' text: [ :each | each version ];
		yourself.
		
	self metadata keysAndValuesDo: [ :k :v |
		list
			column: k text: [ :each | 
				each header 
					at: k 
					ifPresent: [ :obj | obj gtDisplayText ]
					ifAbsent: [ '' ] ] ].
			
	^ list
]

{ #category : #private }
SpFileDatabase class >> availableVersions [

	^ self availableBackups collect: [ :e | 
		e version ].
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
SpFileDatabase class >> backupFiles [

	^ self backupDirectory files select: [ :e | 
			(e basename beginsWith: self name) and: [ e extension isAllDigits ] ].
]

{ #category : #private }
SpFileDatabase class >> backupVersion: aNumber [
	^ self availableBackups
		detect: [ :e | e version = aNumber ]
		ifNone: [ nil ]
]

{ #category : #accessing }
SpFileDatabase class >> dataVersion [
	^ 1
]

{ #category : #accessing }
SpFileDatabase class >> deepRoots [
	"My root data objects, and those of other DBs I contain, recursively all the way through the tree"
	
	^ OrderedCollection streamContents: [ :result |
		self schema do: [ :cls |
			(cls inheritsFrom: SpFileDatabase)
				ifTrue: [ result nextPutAll: cls roots ]
				ifFalse: [ result << cls spData ] ] ]
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

	| lastBackup |
	lastBackup := self availableBackups detectMax: [:each | each version].
	^ lastBackup isNil
		ifTrue: [ 0 ]
		ifFalse: [ lastBackup version ].
	
]

{ #category : #accessing }
SpFileDatabase class >> materialize: anSpBackup [

	| migrations |
	
	migrations := self
		migrationsFrom: anSpBackup dataVersion
		to: self dataVersion.
	
	migrations do: [ :mig | mig preMaterialize value ].
		
	self serializer 
		materialize: anSpBackup
		withMigrations: migrations.
	
	migrations do: [ :mig | mig postMaterialize cull: anSpBackup spData ].
]

{ #category : #accessing }
SpFileDatabase class >> metadata [
	^ Dictionary new
		at: #dataVersion put: self dataVersion;
		yourself
]

{ #category : #accessing }
SpFileDatabase class >> migrationsFrom: sourceVersion to: targetVersion [

	| migrationPragmas migrations relevantMigrations |
	sourceVersion < targetVersion ifFalse: [ ^ #() ].
		
	migrationPragmas := Pragma 
		allNamed: #dataMigration 
		from: self class
		to: Object class.
		
	migrations := migrationPragmas collect: [ :pragma | self perform: pragma methodSelector ].
	
	relevantMigrations := migrations select: [ :mig | mig dataVersion > sourceVersion and: [ mig dataVersion <= targetVersion ] ].
	
	^ relevantMigrations sorted: #dataVersion ascending. 
]

{ #category : #accessing }
SpFileDatabase class >> newBackup [

	^ SpNewBackup newForDatabase: self
]

{ #category : #accessing }
SpFileDatabase class >> projectName [
	^ self name allButLast: 2
]

{ #category : #restoring }
SpFileDatabase class >> restoreBackupVersion: aNumber [
	(self backupVersion: aNumber)
		ifNotNil: [ :backup | backup restore ]
]

{ #category : #accessing }
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
	| version |
	lock ifNil: [ lock := Semaphore forMutualExclusion ].
	lock critical: [
		self trimBackups.
		version := self lastBackupVersion + 1.
		self serializer serialize: self newBackup to: self backupDirectory / self name, version asString ].
]

{ #category : #saving }
SpFileDatabase class >> saveRepositoryAndNotify [
	| beforeStamp newBackup didSucceed priorBackupVersion |
	"Truncate because creation time below may have second precision"
	beforeStamp := DateAndTime now truncated.
	priorBackupVersion := self lastBackup version.
	
	self saveRepository.

	newBackup := self backupVersion: priorBackupVersion + 1.
	didSucceed := newBackup file size > 0 and: [ newBackup file creationTime >= beforeStamp ].
	didSucceed ifFalse: [ self error: self name , ' failed to save' ].
	UIManager default inform: self name , ' saved on ' , beforeStamp printString
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
	entries := self availableBackups.
	entries size < versionsToKeep ifTrue: [ ^ self ].
	entries sort: [ :e | e file extension asInteger ]  descending.
	(entries allButFirst: versionsToKeep) do: [ :entry | entry delete ].
]

{ #category : #viewing }
SpFileDatabase class >> viewBackupDirectory [
	self backupDirectory peOpen
]
