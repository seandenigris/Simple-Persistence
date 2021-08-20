"
I am used by SpFileDatabase to do the actual serialization and materialization. Currently, Fuel is the only supported serializer. The original ReferenceStream serializer has been packaged as SimplePersistence-ReferenceStream just in case a legacy system requires it, but there is no hook to install it, so you'd have to override SpFileDatabase>>serializer.
"
Class {
	#name : 'SpSerializer',
	#superclass : 'Object',
	#category : 'SimplePersistence-Core-Core'
}

{ #category : 'protocol' }
SpSerializer >> materializeFrom: aFileReference [

	self subclassResponsibility.
]

{ #category : 'protocol' }
SpSerializer >> serialize: anObject to: aFileReference [

	self subclassResponsibility.
]
