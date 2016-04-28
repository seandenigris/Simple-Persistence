initialization
initializePresenter
	
	listModel whenSelectedItemChanged: [ :selection |
		selection 
			ifNotNil: [ :class | classDefinition text: class class definition ] ].