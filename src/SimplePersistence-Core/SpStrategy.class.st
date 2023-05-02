"
I am used by SpFileDatabase to do the actual serialization and materialization. Currently, Fuel is the only supported serializer. The original ReferenceStream serializer has been packaged as SimplePersistence-ReferenceStream just in case a legacy system requires it, but there is no hook to install it, so you'd have to override SpFileDatabase>>serializer.
"
Class {
	#name : #SpStrategy,
	#superclass : #Object,
	#category : #'SimplePersistence-Core-Core'
}

{ #category : #accessing }
SpStrategy class >> default [
	^ self allSubclasses detect: #isActive ifFound: [ :cls | cls new ] ifNone: [ nil ]
]

{ #category : #protocol }
SpStrategy >> materializeFrom: aFileReference [

	self subclassResponsibility.
]

{ #category : #protocol }
SpStrategy >> serializeDB: anSpFileDatabase to: aFileReference [

	self serialize: anSpFileDatabase newBackup to: aFileReference
]
