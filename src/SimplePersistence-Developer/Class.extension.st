Extension { #name : #Class }

{ #category : #'*SimplePersistence-Developer' }
Class >> hasClassSideInstVars [

	^ self class instVarNames ~= #().
]

{ #category : #'*SimplePersistence-Developer' }
Class >> persist: aSymbol [
	"
	aSymbol - name of the instanceVariable to persist
	See Object>>#persistIn:as: for more information"

	self persister persist: aSymbol in: self.
]

{ #category : #'*SimplePersistence-Developer' }
Class >> persister [

	^ SpFileDatabase.
]
