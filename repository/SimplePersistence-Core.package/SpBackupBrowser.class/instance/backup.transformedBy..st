as yet unclassified
backup: root transformedBy: aBlock
	root ifNil: [ ^ root ].
	aBlock ifNil: [ ^ root ].
	^ [ aBlock value: root ] on: Error do: [ :e | e ]