Class {
	#name : #SpPersistenceAnalyzer,
	#superclass : #SpPresenter,
	#instVars : [
		'okButton',
		'colorLabel',
		'buyLevelLabel',
		'sellLevelLabel',
		'colorModel',
		'buyLevelModel',
		'dateModel',
		'sellLevelModel',
		'listModel',
		'classDefinition'
	],
	#category : #'SimplePersistence-UI'
}

{ #category : #'as yet unclassified' }
SpPersistenceAnalyzer class >> open [

	self new openWithSpec.
]

{ #category : #'as yet unclassified' }
SpPersistenceAnalyzer class >> spec [
	<spec: #default>

	^ SpecLayout composed
			newRow: [ :row | row
				newColumn: [ :col | col add: #listModel ];
				newColumn: [ :col | col add: #classDefinition ] ];
			yourself.
]

{ #category : #'as yet unclassified' }
SpPersistenceAnalyzer class >> title [

	^ 'Classes which may need to be persisted'.
]

{ #category : #accessing }
SpPersistenceAnalyzer >> classDefinition [

	^ classDefinition.
]

{ #category : #private }
SpPersistenceAnalyzer >> classesPossiblyNeedingPersistence [

	^ self classesPossiblyNeedingPersistenceIn: self packages.
]

{ #category : #'private-model' }
SpPersistenceAnalyzer >> classesPossiblyNeedingPersistenceIn: packageCollection [

	^ packageCollection inject: OrderedCollection new into: [ :col :p | | possPersistentClasses |
			possPersistentClasses := p definedClasses select: [ :c |
				c hasClassSideInstVars and: [ self noDbPersists: c ] ].
			col addAll: possPersistentClasses.
			col ].
]

{ #category : #initialization }
SpPersistenceAnalyzer >> initializePresenter [
	
	listModel whenSelectedItemChanged: [ :selection |
		selection 
			ifNotNil: [ :class | classDefinition text: class class definition ] ].
]

{ #category : #initialization }
SpPersistenceAnalyzer >> initializeWidgets [

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
]

{ #category : #accessing }
SpPersistenceAnalyzer >> listModel [

	^ listModel.
]

{ #category : #'private-model' }
SpPersistenceAnalyzer >> noDbPersists: aClass [ 

	^ self persistenceClasses noneSatisfy: [ :db | db persists: aClass ].
]

{ #category : #accessing }
SpPersistenceAnalyzer >> okButton [

	^ okButton.
]

{ #category : #'private-model' }
SpPersistenceAnalyzer >> packages [

	self flag: 'hard code to bootstrap'.
	^ RPackage organizer packages select: [ :e | e name beginsWith: 'TradeMaster' ].
]

{ #category : #'private-model' }
SpPersistenceAnalyzer >> persistenceClasses [

	^ self packages inject: OrderedCollection new into: [ :col :p | | dbs |
		dbs := p definedClasses select: [ :c | c includesBehavior: SpFileDatabase ].
		col addAll: dbs.
		col ].
]
