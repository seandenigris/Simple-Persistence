"
I help visualize models where the object references have been broken, causing model fragmentation and duplicate instances. This can happen due to incorrect serialization/materialization.

For example, if your model graph root was `{ A. B }`, where:
	A -> B
	C -> B
You might end up with:
	A -> B
	C -> B'
There are now two different copies of B.

I will show you which instances are probably duplicates and which are okay. Check out this example: {{gtExample:SpInstanceDeDuplicator class>>#example}}
"
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

{ #category : #examples }
SpInstanceDeDuplicator class >> example [
	<gtExample>
	
	| canon objs |
	^ self
		given: [ 
			canon := { 1@1. 2@2 }.
			objs := OrderedCollection new
				addAll: canon;
				add: canon atRandom copy;
				add: 3@3;
				yourself ]
		when: [ 
			(SpInstanceDeDuplicator forObjects: objs)
				canonInclusionTest: [ :e | canon identityIncludes: e ];
				idBlock: [ :e | e printString ];
				yourself ]
		then: [ :d |
			d selectMergable groups should haveSize: 1.
			d selectValid groups should haveSize: canon size - 1.
			d selectUnmergable groups should haveSize: 1 ]
]

{ #category : #accessing }
SpInstanceDeDuplicator class >> forObjects: aCollection [ 
	^ self new
		objects: aCollection;
		yourself
]

{ #category : #accessing }
SpInstanceDeDuplicator >> autoMerge [
	self selectMergable groups do: #merge
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
SpInstanceDeDuplicator >> copySelect: aBlock [

	| selectedGroups objs |
	selectedGroups := self groups select: aBlock.
	objs := (selectedGroups flatCollect: #instances) asIdentitySet.
	^ self copyForObjects: objs
]

{ #category : #accessing }
SpInstanceDeDuplicator >> fieldConditions [

	^ fieldConditions ifNil: [ 
		{ 
			#yourself -> [ :r | true ] 
		} ].
]

{ #category : #accessing }
SpInstanceDeDuplicator >> fieldConditions: anObject [

	fieldConditions := anObject
]

{ #category : #accessing }
SpInstanceDeDuplicator >> groupConditions [

	^ groupConditions ifNil: [ 
		{ 
			[ :insts :grp | 
				| oCol |
				oCol := grp instances asOrderedCollection.
				oCol size > 1 
					ifTrue: [ (oCol first patchRelativeToBase: oCol second) operations isEmpty ]
					ifFalse: [ true ] ]
		} ]
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

	^ self copySelect: #isMergable
]

{ #category : #accessing }
SpInstanceDeDuplicator >> selectUnmergable [

	^ self copySelect: [ :e | e isMergable not and: [ e isValid not ] ]
]

{ #category : #accessing }
SpInstanceDeDuplicator >> selectValid [

	^ self copySelect: #isValid
]

{ #category : #accessing }
SpInstanceDeDuplicator >> statusIconFor: anObject [
	
	(anObject isKindOf: SpSuspectedDuplicateGroup) ifTrue: [ 
		^ anObject statusIcon ].
			
	^ (self canonInclusionTest value: anObject)
		ifTrue: [ BrGlamorousIcons greencircle ]
		ifFalse: [ BrGlamorousIcons redcircle ].
]
