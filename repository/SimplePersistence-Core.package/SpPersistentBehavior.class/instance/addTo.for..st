as yet unclassified
addTo: aClass for: aSymbol 

	| template source |
	template := 
'restoreFrom: anObject

	{2} := anObject.'.
	source := template format: { aSymbol }.
	aClass class compile: source classified: 'persistence'.