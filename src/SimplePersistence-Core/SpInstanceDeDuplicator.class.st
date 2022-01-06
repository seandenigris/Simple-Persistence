Class {
	#name : #SpInstanceDeDuplicator,
	#superclass : #Object,
	#instVars : [
		'objects',
		'groups',
		'canonInclusionTest',
		'fieldConditions',
		'groupConditions',
		'idBlock',
		'postMergeAction'
	],
	#category : #'SimplePersistence-Core-DeDuplication'
}

{ #category : #accessing }
SpInstanceDeDuplicator class >> example [
	<gtExample>
	
	^ self
		given: [ SpInstanceDeDuplicator forObjects: { 1. 1.0. 2 } ]
		when: [ :d | d canonInclusionTest: [ :e | #(2) includes: e ] ]
		then: [ :d | ]
]

{ #category : #accessing }
SpInstanceDeDuplicator class >> forObjects: aCollection [ 
	^ self new
		objects: aCollection;
		yourself
]

{ #category : #accessing }
SpInstanceDeDuplicator >> autoMerge [
	self mergableGroups do: #merge
]

{ #category : #accessing }
SpInstanceDeDuplicator >> canonInclusionTest [

	^ canonInclusionTest
]

{ #category : #accessing }
SpInstanceDeDuplicator >> canonInclusionTest: anObject [

	canonInclusionTest := anObject
]

{ #category : #accessing }
SpInstanceDeDuplicator >> childrenFor: anObject [

	(anObject isKindOf: SpSuspectedDuplicateGroup) ifTrue: [ 
		^ anObject instances ].
	^ #()
]

{ #category : #accessing }
SpInstanceDeDuplicator >> copyForObjects: aCollection [
	^ (self class forObjects: aCollection)
		idBlock: self idBlock;
		canonInclusionTest: self canonInclusionTest;
		groupConditions: self groupConditions;
		fieldConditions: self fieldConditions;
		yourself
		
]

{ #category : #accessing }
SpInstanceDeDuplicator >> fieldConditions [

	^ fieldConditions
]

{ #category : #accessing }
SpInstanceDeDuplicator >> fieldConditions: anObject [

	fieldConditions := anObject
]

{ #category : #accessing }
SpInstanceDeDuplicator >> groupConditions [

	^ groupConditions
]

{ #category : #accessing }
SpInstanceDeDuplicator >> groupConditions: anObject [

	groupConditions := anObject
]

{ #category : #accessing }
SpInstanceDeDuplicator >> groups [
	| dict |
	groups ifNotNil: [ ^ groups ].
	dict := self objects groupedBy: self idBlock.
	^ groups := OrderedCollection streamContents: [ :str |
		dict keysAndValuesDo: [ :k :v |
			| group |
			group := SpSuspectedDuplicateGroup new
				client: self;
				id: k;
				instances: v;
				yourself.
			str nextPut: group ] ].
]

{ #category : #accessing }
SpInstanceDeDuplicator >> gtViewTreeOn: aView [
	<gtView>
	^ aView columnedTree
		title: 'Objects' translated;
		priority: 80;
		items: [ self groups ];
		children: [ :e | self childrenFor: e ]; 
		column: 'Status' 
			icon: [ :e | self statusIconFor: e ]
			width: 75;
		column: 'Name' text: [ :p | p asString asRopedText ];
		"column: 'Actions' 
			icon: [ :p | p actionButtons first ]
			width: 500;"
		actionUpdateButtonTooltip: 'Update'
]

{ #category : #accessing }
SpInstanceDeDuplicator >> idBlock [

	^ idBlock
]

{ #category : #accessing }
SpInstanceDeDuplicator >> idBlock: anObject [

	idBlock := anObject
]

{ #category : #accessing }
SpInstanceDeDuplicator >> includedClasses [
	^ self objects collect: #class as: Set
]

{ #category : #accessing }
SpInstanceDeDuplicator >> mergableGroups [

	^ self groups select: #isMergable
]

{ #category : #accessing }
SpInstanceDeDuplicator >> objects [

	^ objects
]

{ #category : #accessing }
SpInstanceDeDuplicator >> objects: anObject [

	objects := anObject
]

{ #category : #accessing }
SpInstanceDeDuplicator >> postMergeAction [

	^ postMergeAction ifNil: [ postMergeAction := [ :grp | ] ]
]

{ #category : #accessing }
SpInstanceDeDuplicator >> postMergeAction: anObject [

	postMergeAction := anObject
]

{ #category : #accessing }
SpInstanceDeDuplicator >> printOn: aStream [

	aStream
		print: self groups size;
		nextPutAll: ' groups'
]

{ #category : #accessing }
SpInstanceDeDuplicator >> reset [
	groups := nil
]

{ #category : #accessing }
SpInstanceDeDuplicator >> selectMergable [

	^ self copyForObjects: (self mergableGroups flatCollect: #instances) asIdentitySet
]

{ #category : #accessing }
SpInstanceDeDuplicator >> selectUnmergable [

	^ self copyForObjects: ((self groups reject: [ :e | e isMergable or: [ e isValid ] ]) flatCollect: #instances) asIdentitySet.
]

{ #category : #accessing }
SpInstanceDeDuplicator >> selectValid [

	^ self copyForObjects: (self validGroups flatCollect: #instances) asIdentitySet.
]

{ #category : #accessing }
SpInstanceDeDuplicator >> statusIconFor: anObject [
	
	(anObject isKindOf: SpSuspectedDuplicateGroup) ifTrue: [ 
		^ anObject statusIcon ].
			
	^ (self canonInclusionTest value: anObject)
		ifTrue: [ BrGlamorousIcons greencircle ]
		ifFalse: [ BrGlamorousIcons redcircle ].
]

{ #category : #accessing }
SpInstanceDeDuplicator >> validGroups [

	^ self groups select: #isValid
]
