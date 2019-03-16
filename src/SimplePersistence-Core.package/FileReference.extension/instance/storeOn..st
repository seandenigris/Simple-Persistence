*SimplePersistence-Core
storeOn: aStream
	aStream nextPut: $'.
	filesystem printPath: path on: aStream.
	aStream nextPutAll: ''' asFileReference'.