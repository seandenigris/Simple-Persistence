Extension { #name : #SpFileDatabase }

{ #category : #'*SimplePersistence-UI' }
SpFileDatabase class >> disablePersistenceDescription [
	"Disable while playing with #togglePersistence, which may replace me.
	<magritteActionDescription>"
	
	^ MAActionDescription new
			action: #disablePersistence;
			enableBlock: [ :e | e isPersistenceEnabled ];
			yourself
]

{ #category : #'*SimplePersistence-UI' }
SpFileDatabase class >> restoreLastBackupDescription [
	<magritteActionDescription>
	
	^ MAActionDescription new
			action: #restoreLastBackup;
			label: 'Restore Last Backup';
			isMutator: false;
			shortcut: $r asShortcut;
			yourself
]

{ #category : #'*SimplePersistence-UI' }
SpFileDatabase class >> saveRepositoryDescription [
	<magritteActionDescription>
	
	^ MAActionDescription new
			action: #saveRepositoryAndNotify;
			label: 'Save Repository';
			isMutator: true;
			shortcut: $s asShortcut;
			yourself.
]

{ #category : #'*SimplePersistence-UI' }
SpFileDatabase class >> togglePersistenceDescription [
	<magritteActionDescription>
	
	^ MAActionDescription new
			action: #togglePersistence;
			label: 'Toggle Persistence';
			isMutator: true;
			shortcut: $t asShortcut;
			yourself
]

{ #category : #'*SimplePersistence-UI' }
SpFileDatabase class >> viewBackupDirectoryDescription [
	<magritteActionDescription>
	
	^ MAActionDescription new
			action: #viewBackupDirectory;
			shortcut: $v asShortcut;
			yourself.
]

{ #category : #'*SimplePersistence-UI' }
SpFileDatabase class >> viewDataDescription [
	<magritteActionDescription>
	
	^ MAActionDescription new
			action: [ :db | db spData inspect ];
			label: 'View Data';
			isMutator: false;
			shortcut: #v asShortcut;
			yourself
]
