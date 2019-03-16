protocol
serialize: anObject to: aFileReference

	ReferenceStream 
		newFileNamed: aFileReference fullName
		do: [ :stream | 
				stream
					nextPut: anObject;
					flush ].