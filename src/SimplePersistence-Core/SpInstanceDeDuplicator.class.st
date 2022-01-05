Class {
	#name : #SpInstanceDeDuplicator,
	#superclass : #Object,
	#instVars : [
		'objects',
		'byClass',
		'includedClasses',
		'classMap',
		'groups'
	],
	#category : #'SimplePersistence-Core-DeDuplication'
}

{ #category : #accessing }
SpInstanceDeDuplicator class >> forObjects: aCollection [ 
	^ self new
		objects: aCollection;
		yourself
]

{ #category : #accessing }
SpInstanceDeDuplicator >> byClass [
	^ byClass ifNil: [ byClass := self objects groupedBy: [ :e | e class ] ]
]

{ #category : #accessing }
SpInstanceDeDuplicator >> childrenFor: anObject [

	anObject isClass ifTrue: [ ^ self childrenForClass:anObject ].
	(anObject isKindOf: AbstractFileReference) ifTrue: [ 
		| filesToResources |
		filesToResources := self classMap values detect: [ :e | e includesKey: anObject ].
		^ filesToResources at: anObject ].
	^ #()
]

{ #category : #accessing }
SpInstanceDeDuplicator >> childrenForClass: aClass [

	| mapValue |
	mapValue := self classMap
		at: aClass
		ifAbsentPut: [ 
			| instances |
			instances := self objects select: [ :e | e class = aClass ].
			instances groupedBy: [ :e | e file ] ].
	^ mapValue keys
]

{ #category : #accessing }
SpInstanceDeDuplicator >> classMap [
	^ classMap ifNil: [ classMap := Dictionary new ]
]

{ #category : #accessing }
SpInstanceDeDuplicator >> groups [
	| dict |
	groups ifNotNil: [ ^ groups ].
	dict := self objects groupedBy: [ :e | e file ].
	^ groups := OrderedCollection streamContents: [ :str |
		dict keysAndValuesDo: [ :k :v |
			| group |
			group := SpSuspectedDuplicateGroup new
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
		items: [ self includedClasses ];
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
SpInstanceDeDuplicator >> includedClasses [
	^ includedClasses ifNil: [ includedClasses := self objects collect: #class as: Set ]
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
SpInstanceDeDuplicator >> statusIconFor: anObject [
	| canonInclusionTest |
	
	canonInclusionTest := [ :e | RlResourceLibrary uniqueInstance resources identityIncludes: e ].
	
	(anObject isKindOf: Class) ifTrue: [ 
		^ BrGlamorousIcons graycircle ].
			
	(anObject isKindOf: AbstractFileReference) ifTrue: [ 
		| matchingChildren |
		matchingChildren := self childrenFor: anObject.
		^ (matchingChildren size = 1 and: [ matchingChildren allSatisfy: canonInclusionTest ])
			ifTrue: [ BrGlamorousIcons greencircle ]
			ifFalse: [ BrGlamorousIcons redcircle ] ].
			
	^ (canonInclusionTest value: anObject)
		ifTrue: [ BrGlamorousIcons greencircle ]
		ifFalse: [ BrGlamorousIcons redcircle ].
]
