as yet unclassified
unregisterClassNamed: aString 

	| class |
	class := Smalltalk classNamed: aString.
	Smalltalk
		removeFromStartUpList: class;
		removeFromShutDownList: class