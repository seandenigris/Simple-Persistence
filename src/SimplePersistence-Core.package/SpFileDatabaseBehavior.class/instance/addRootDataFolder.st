setting up
addRootDataFolder

	| sourceTemplate source |
	sourceTemplate := 'rootDataFolder
	^ {fileReference}'.
	source := sourceTemplate format: { #fileReference -> self rootDataFolderRecipe } asDictionary.
	self databaseClass class compile: source classified: 'accessing'.