Extension { #name : #FileReferenceTest }

{ #category : #'*SimplePersistence-Core' }
FileReferenceTest >> testStoreOn [
	| original recipe clone |
	original := 'root/sub1/sub2' asFileReference.
	recipe := String streamContents: [ :s | original storeOn: s ].
	clone := Compiler evaluate: recipe.
	self assert: original equals: clone
]
