setting up
addRepositoryAccessorFor: aSymbol of: aClass 

	| template source |
	template := 
'repositories

	^ \{ {1} {2} \}.'.
	source := template format: { aClass name. aSymbol }.
	self databaseClass class compile: source.