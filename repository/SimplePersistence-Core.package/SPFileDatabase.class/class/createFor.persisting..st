setting up
createFor: aClass persisting: aSymbol 

	| topLevelCategory dbClassName dbClass |
	topLevelCategory := aClass category copyUpTo: $-.
	dbClassName := (aClass name, 'DB') asSymbol.
	dbClass := SPFileDatabase subclass: dbClassName
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: topLevelCategory, '-Persistence'.
	dbClass
		addInitializer;
		addRepositoryAccessorFor: aSymbol of: aClass;
		addRestorationMethodFor: aClass.