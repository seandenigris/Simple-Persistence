*SimplePersistence-Core-Developer
backupBrowser
	<script>
	
	| dbs browser |
	dbs := self subclasses.
	browser := GLMTabulator new
		column: [ :c |
			c
				row: [ :r |
					r
						column: #dbs;
						column: #backups ] span: 2;
				row: #transformation ];
		column: #data span: 3;
		yourself.
	browser transmit to: #transformation; andShow: [ :a | 
		a pharoScript 
			display: '[ :modelRoot | modelRoot ]';
			populate: #acceptedCode icon: GLMUIThemeExtraIcons glamorousAccept on: $s entitled: 'Accept' with: [:text | Compiler evaluate: text text ] ].
	browser transmit to: #dbs; andShow: [ :a | a list ].
	browser transmit
		from: #dbs;
		to: #backups;
		andShow: [ :a :db | 
			a list
				title: 'Backups';
				display: [ db availableVersions sorted reversed ];
				send: [ :version | [ db backupVersion: version ] on: Error do: [ :e | e ] ] ].
	browser transmit
		from: #transformation port: #acceptedCode;
		from: #backups;
		transformed: [ :trans :bu | self backup: bu transformedBy: trans ];
		to: #data;
		andShow: [ :a | a finder show: [ :b :object | object gtInspectorPresentationsIn: b inContext: GTInspector new ] ].
	browser openOn: dbs