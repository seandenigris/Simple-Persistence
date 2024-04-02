Extension { #name : #SpFileDatabase }

{ #category : #'*SimplePersistence-Developer' }
SpFileDatabase class >> backupBrowser [
	<script>
	
	| dbs |
	dbs := self subclasses.
	SpBackupBrowser openOn: dbs
]

{ #category : #'*SimplePersistence-Developer' }
SpFileDatabase class >> menuCommandOn: aBuilder [ 
	<worldMenu> 
	
	(aBuilder item: #'Simple Persistence')
		with: [
			(aBuilder item: #'Backup Browser')
				action: [ self backupBrowser ]; 
				icon: Smalltalk ui icons glamourousTable. ]
]
