as yet unclassified
addTo: aClass for: aSymbol 

	| genericInstance template source |
	genericInstance := (aClass name first isVowel ifTrue: ['an'] ifFalse: ['a']), aClass name.
	template := 
'restoreFrom: {1}

	{2} := {1}.'.
	source := template format: { genericInstance. aSymbol }.
	aClass class compile: source classified: 'persisting'.