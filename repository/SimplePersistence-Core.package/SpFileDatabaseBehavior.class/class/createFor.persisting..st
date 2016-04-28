setting up
createFor: aClass persisting: aSymbol 

	| instance |
	instance := self new
			containerClass: aClass;
			instVarName: aSymbol.
	^ instance create.