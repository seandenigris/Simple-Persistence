setting up
databaseClass
	
	| topLevelCategory dbClassName |
	databaseClass ifNil: [
		topLevelCategory := containerClass category copyUpTo: $-.
		dbClassName := (topLevelCategory, 'DB') asSymbol.
		databaseClass := SpFileDatabase subclass: dbClassName
		instanceVariableNames: ''
		classVariableNames: ''
		poolDictionaries: ''
		category: topLevelCategory, '-Persistence' ].
	
	^ databaseClass.