as yet unclassified
registerUserClassNamed: aString 
	
	| class |
	class := Smalltalk classNamed: aString.
	Smalltalk
		addToStartUpList: class;
		addToShutDownList: class