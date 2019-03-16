private
rootDataFolderRecipe
	^ String streamContents: [:s | SpFileDatabase rootDataFolder storeOn: s ]