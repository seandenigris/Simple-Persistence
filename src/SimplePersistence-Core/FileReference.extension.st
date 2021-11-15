Extension { #name : #FileReference }

{ #category : #'*SimplePersistence-Core' }
FileReference >> storeOn: aStream [
	aStream nextPut: $'.
	filesystem printPath: path on: aStream.
	aStream nextPutAll: ''' asFileReference'.
]
