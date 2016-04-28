*SimplePersistence-Core-Developer
simplePersistenceClassMenu: aBuilder
	<nautilusGlobalClassMenu>

	| target selectedClass |
	target := aBuilder model.
	selectedClass := target selectedClass.
	(selectedClass isNil or: [ target selectedClass isMeta not ]) ifTrue: [ ^ self ].
	(aBuilder item: #'Persist inst var...')
		action: [ | accessor varNames index |
			varNames := selectedClass instVarNames.
			index := UIManager default chooseFrom: varNames.
			(index = 0) ifTrue: [ ^ self ].
			accessor := varNames at: index.
			selectedClass soleInstance persist: accessor ];
		order: 0;
		help: 'SimplePersistence: persist inst var (must have accessor w same name)'.