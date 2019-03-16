*SimplePersistence-Core
testStoreOn
	| original recipe clone |
	original := FileLocator home / 'subfolder'.
	recipe := String streamContents: [ :s | original storeOn: s ].
	clone := Compiler evaluate: recipe.
	self assert: original equals: clone