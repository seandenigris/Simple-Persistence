Class {
	#name : #SpSuspectedDuplicateGroup,
	#superclass : #Object,
	#instVars : [
		'instances',
		'id'
	],
	#category : #'SimplePersistence-Core-DeDuplication'
}

{ #category : #accessing }
SpSuspectedDuplicateGroup >> id [

	^ id
]

{ #category : #accessing }
SpSuspectedDuplicateGroup >> id: anObject [

	id := anObject
]

{ #category : #accessing }
SpSuspectedDuplicateGroup >> instances [

	^ instances
]

{ #category : #accessing }
SpSuspectedDuplicateGroup >> instances: anObject [

	instances := anObject
]
