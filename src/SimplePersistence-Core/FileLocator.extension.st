Extension { #name : 'FileLocator' }

{ #category : '*SimplePersistence-Core' }
FileLocator >> storeOn: aStream [
	aStream
		nextPutAll: self className;
		space;
		nextPutAll: origin.
	self path do: [ :part | 
		aStream
			nextPutAll: ' / ';
			print: part ]
]
