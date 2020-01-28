Class {
	#name : #SpReferenceStreamSerializer,
	#superclass : #SpSerializer,
	#category : 'SimplePersistence-ReferenceStream'
}

{ #category : #protocol }
SpReferenceStreamSerializer >> materializeFrom: aFileReference [

	^ ReferenceStream 
			readOnlyFileNamed: aFileReference fullName
			do: [ : f | f next ].
]

{ #category : #protocol }
SpReferenceStreamSerializer >> serialize: anObject to: aFileReference [

	ReferenceStream 
		newFileNamed: aFileReference fullName
		do: [ :stream | 
				stream
					nextPut: anObject;
					flush ].
]
