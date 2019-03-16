initialization
initializeWidgets

    | colorItems |
	self instantiateModels: {
		#listModel -> #ListComposableModel.
		#classDefinition -> #TextInputFieldModel
		"#colorLabel -> #LabelModel.
		#colorModel -> #DropListModel.
		#buyLevelLabel -> #LabelModel.
		#buyLevelModel -> #TextModel.
		#sellLevelLabel -> #LabelModel.
		#sellLevelModel -> #TextModel.
		#okButton -> #ButtonModel" }.
		
	listModel
		items: self classesPossiblyNeedingPersistence;
		displayBlock: [ :e | e name ].
		
"	colorLabel text: 'Color'.
	colorItems := #('Green' 'Red' 'Yellow') collect: [ :e | DropListItem named: e do: [] ].
	colorModel
		items: colorItems.
	
	buyLevelLabel text: 'Buy Level'.
	
	sellLevelLabel text: 'Sell Level'.
	
	self focusOrder
		add: colorModel;
		add: buyLevelModel;
		add: sellLevelModel.
	self focusOrder add: okButton.	
	okButton	
		label: 'Next';
		action: [ self ok ]."