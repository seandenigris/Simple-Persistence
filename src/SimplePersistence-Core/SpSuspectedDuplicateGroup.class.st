Class {
	#name : #SpSuspectedDuplicateGroup,
	#superclass : #Object,
	#traits : 'MATPropertyOwner',
	#classTraits : 'MATPropertyOwner classTrait',
	#instVars : [
		'instances',
		'id'
	],
	#category : #'SimplePersistence-Core-DeDuplication'
}

{ #category : #accessing }
SpSuspectedDuplicateGroup >> canonInclusionTest [
	^ [ :e | RlResourceLibrary uniqueInstance resources identityIncludes: e ].
]

{ #category : #accessing }
SpSuspectedDuplicateGroup >> canonical [
	^ self instances detect: self canonInclusionTest ifNone: [ nil ]
]

{ #category : #accessing }
SpSuspectedDuplicateGroup >> fieldConditions [
	
	^ { 
		#originalFile -> [ :e :seed | 
		seed
			ifNil: [ e originalFile isNil ]
			ifNotNil: [ e originalFile resolve == seed resolve ] ].
		#source -> [ :e :s | e source = s ].
		#importTimestamp -> [ :e :s | e importTimestamp = s ].
		#metadata -> [ :e :s | e metadata = s ].
		#yourself -> [ :r | r properties keys hasEqualElements: #(#llWork) ]
	}
]

{ #category : #accessing }
SpSuspectedDuplicateGroup >> groupConditions [
	
	^ { 
		[ :insts | insts anySatisfy: [ :r | 
			LlLibrary uniqueInstance works 
				detect: [ :w | w == (r propertyAt: #llWork) ]
				ifFound: [ :w | 
					self propertyAt: #llWork put: w.
					true ]
				ifNone: [ false ] ] ] }
]

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

{ #category : #accessing }
SpSuspectedDuplicateGroup >> isMergable [
	
	| didFieldConditionsPass didGroupConditionsPass |
	self instances size > 1 ifFalse: [ ^ false ].
	(self instances select: self canonInclusionTest) size = 1 ifFalse: [ ^ false ].
	
	didFieldConditionsPass := self fieldConditions allSatisfy: [ :assoc |
		| seed |
		seed := self instances atRandom perform: assoc key.
		self instances allSatisfy: [ :e | assoc value cull: e cull: seed ] ].
	didFieldConditionsPass ifFalse: [ ^ false ].
	
	didGroupConditionsPass := self groupConditions allSatisfy: [ :valuable |
		valuable value: self instances ].
	didGroupConditionsPass ifFalse: [ ^ false ].
	
	^ true
]

{ #category : #accessing }
SpSuspectedDuplicateGroup >> isValid [
	^ self instances size = 1 and: [ 
		self instances allSatisfy: self canonInclusionTest ]
]

{ #category : #accessing }
SpSuspectedDuplicateGroup >> merge [
	| duplicates canonical |
	self isMergable ifFalse: [ ^ self error: 'group not mergable!' ].
	canonical := self canonical.
	duplicates := self instances copyWithout: canonical.
	duplicates do: [ :e | e becomeForward: canonical ].
	self postMergeAction cull: self
]

{ #category : #accessing }
SpSuspectedDuplicateGroup >> postMergeAction [
	^ [ self canonical properties at: #llWork put: (self properties at: #llWork) ]
]

{ #category : #accessing }
SpSuspectedDuplicateGroup >> printOn: aStream [

	aStream
		nextPut: $(;
		print: self instances size;
		nextPutAll: ' objects ';
		print: self id
]

{ #category : #accessing }
SpSuspectedDuplicateGroup >> statusIcon [

	self isValid ifTrue: [ ^ BrGlamorousIcons greencircle ].
	self isMergable ifTrue: [ ^ BrGlamorousIcons yellowcircle ].	
	^ BrGlamorousIcons redcircle
]
