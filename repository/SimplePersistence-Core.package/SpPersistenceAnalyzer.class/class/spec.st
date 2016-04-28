as yet unclassified
spec
	<spec: #default>

	^ SpecLayout composed
			newRow: [ :row | row
				newColumn: [ :col | col add: #listModel ];
				newColumn: [ :col | col add: #classDefinition ] ];
			yourself.