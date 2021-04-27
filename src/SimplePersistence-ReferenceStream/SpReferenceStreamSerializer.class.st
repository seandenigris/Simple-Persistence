Class {
	#name : #SpReferenceStreamSerializer,
	#superclass : #SpSerializer,
	#category : #'SimplePersistence-ReferenceStream'
}

{ #category : #protocol }
SpReferenceStreamSerializer >> materializeFrom: aFileReference [

	^ aFileReference readStreamDo: [ : f | f next ].
]

{ #category : #protocol }
SpReferenceStreamSerializer >> serialize: anObject to: aFileReference [

	aFileReference writeStreamDo: [ :stream | 
				stream
					nextPut: anObject;
					flush ].
]
