Class {
	#name : #SpBackupBrowser,
	#superclass : #GLMCompositePresentation,
	#category : 'SimplePersistence-Core-Developer'
}

{ #category : #'as yet unclassified' }
SpBackupBrowser class >> minimalPersistenceStatusReport [
	<script>
	(self subclasses collect: [ :e | e -> e isPersistenceEnabled ]) asDictionary inspect
]

{ #category : #private }
SpBackupBrowser >> backup: root transformedBy: aBlock [
	root ifNil: [ ^ root ].
	aBlock ifNil: [ ^ root ].
	^ [ aBlock value: root ] on: Error do: [ :e | e ]
]

{ #category : #building }
SpBackupBrowser >> compose [
	self title: 'Backup Browser'.
	self tabulator
		with: [ :browser | 
			browser
				initialExtent: 1250 @ 500;
				column: [ :c | 
					c
						row: [ :r | 
							r
								column: #dbs span: 2;
								column: #backups ]
							span: 2;
						row: #transformation ];
				column: #data span: 2.
			browser transmit
				to: #transformation;
				andShow: [ :a | 
					a pharoScript
						display: '[ :modelRoot | modelRoot ]';
						populate: #acceptedCode
							icon: GLMUIThemeExtraIcons glamorousAccept
							on: $s
							entitled: 'Accept'
							with: [ :text | Smalltalk compiler evaluate: text text ] ].
			browser transmit
				to: #dbs;
				andShow: [ :a | 
					a list
						maAddSelectionActionsFor: SpFileDatabase;
						selectionAct: [ :list | list selection inspect ]
							on: $i
							entitled: 'Inspect';
						icon: [ :db | 
							db isPersistenceEnabled
								ifTrue: [ self iconNamed: #testGreen ]
								ifFalse: [ self iconNamed: #testNotRun ] ];
						format: [ :db | db asString ] ].
			browser transmit
				from: #dbs;
				to: #backups;
				andShow: [ :a :db | 
					a list
						title: 'Backups';
						selectionAct: [ :list | db restoreBackupVersion: list rawSelection ]
							on: $r
							entitled: 'Restore';
						display: [ db availableVersions sorted reversed ];
						send: [ :version | 
							[ db backupVersion: version ]
								on: Error
								do: [ :e | e ] ] ].
			browser transmit
				from: #transformation port: #acceptedCode;
				from: #backups;
				transformed: [ :trans :bu | self backup: bu transformedBy: trans ];
				to: #data;
				andShow: [ :a | 
					a finder
						show:
							[ :b :object | object gtInspectorPresentationsIn: b inContext: GTInspector new ] ] ]
]
