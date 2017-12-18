building
compose

	self tabulator with: [ :browser |
		browser
			initialExtent: 1250@500;
			column: [ :c |
				c
					row: [ :r |
						r
							column: #dbs span: 2;
							column: #backups ] span: 2;
					row: #transformation ];
			column: #data span: 2;
			yourself.
		browser transmit to: #transformation; andShow: [ :a | 
			a pharoScript 
				display: '[ :modelRoot | modelRoot ]';
				populate: #acceptedCode icon: GLMUIThemeExtraIcons glamorousAccept on: $s entitled: 'Accept' with: [:text | Compiler evaluate: text text ] ].
		browser transmit to: #dbs; andShow: [ :a | 
			a list
				maAddSelectionActionsFor: SpFileDatabase;
				selectionAct: [ :list | list selection inspect ] on: $i entitled: 'Inspect';
				icon: [ :db | 
						db isPersistenceEnabled
							ifTrue: [ Smalltalk ui icons testGreen ] 
							ifFalse: [ Smalltalk ui icons testNotRun ] ];
				format: [ :db | 
					db isMainProject
						ifTrue: [ db asString asText allBold ]
						ifFalse: [ db asString ] ] ].
		browser transmit
			from: #dbs;
			to: #backups;
			andShow: [ :a :db | 
				a list
					title: 'Backups';
					selectionAct: [ :list | db restoreBackupVersion: list rawSelection ] on: $r entitled: 'Restore';
					display: [ db availableVersions sorted reversed ];
					send: [ :version | [ db backupVersion: version ] on: Error do: [ :e | e ] ] ].
		browser transmit
			from: #transformation port: #acceptedCode;
			from: #backups;
			transformed: [ :trans :bu | self backup: bu transformedBy: trans ];
			to: #data;
			andShow: [ :a | a finder show: [ :b :object | object gtInspectorPresentationsIn: b inContext: GTInspector new ] ] ].