Extension { #name : #FileLocatorTest }

{ #category : #'*SimplePersistence-Core' }
FileLocatorTest >> testStoreOn [
	| original recipe clone |
	original := FileLocator home / 'subfolder'.
	recipe := String streamContents: [ :s | original storeOn: s ].
	clone := Smalltalk compilerClass new
		source: recipe;
		evaluate.
	self assert: original equals: clone
]
