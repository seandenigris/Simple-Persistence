Extension { #name : #AbstractFileReference }

{ #category : #'*SimplePersistence-Platform' }
AbstractFileReference >> ensureCreateDirectory [

	^ self ensureDirectory.
]
