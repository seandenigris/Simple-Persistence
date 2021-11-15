Class {
	#name : #SpGreedyInitRule,
	#superclass : #RBBlockLintRule,
	#category : 'SimplePersistence-Core-Developer'
}

{ #category : #testing }
SpGreedyInitRule class >> checksMethod [
	^ true
]

{ #category : #accessing }
SpGreedyInitRule class >> uniqueIdentifierName [
	"This number should be unique and should change only when the rule completely change semantics"
	
	^'SpOldDbInitRule'
]

{ #category : #running }
SpGreedyInitRule >> basicCheck: aMethod [
	
	aMethod spIsDbInitOverride ifFalse: [ ^ false ].
	^ aMethod ast sentMessages includes: #enablePersistence
]

{ #category : #running }
SpGreedyInitRule >> checkMethod: aMethod [
	(self basicCheck: aMethod)
		ifTrue: [ result addMethod: aMethod ]
]

{ #category : #accessing }
SpGreedyInitRule >> group [
	^ 'Bugs'
]

{ #category : #accessing }
SpGreedyInitRule >> name [
	^ 'SP DB Doesn''t Respect Library-Mode'
]

{ #category : #accessing }
SpGreedyInitRule >> rationale [
	^ 'If a project is used as a library supporting another project, you may not want to save the data in the usual place/way.'
]

{ #category : #accessing }
SpGreedyInitRule >> resultClass [
	^ RBSelectorEnvironment
]
