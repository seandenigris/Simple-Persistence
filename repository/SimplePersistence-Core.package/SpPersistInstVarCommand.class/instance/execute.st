execution
execute
	| accessor varNames index |
	varNames := targetClass class instVarNames.
	index := UIManager default chooseFrom: varNames.
	index = 0
		ifTrue: [ ^ self ].
	accessor := varNames at: index.
	targetClass persist: accessor