Class {
	#name : 'SpPersistInstVarCommand',
	#superclass : 'SycSingleClassCommand',
	#category : 'SimplePersistence-Core-Developer',
	#package : 'SimplePersistence-Core',
	#tag : 'Developer'
}

{ #category : 'activation' }
SpPersistInstVarCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	^ CmdContextMenuActivation byRootGroupItemFor: ClyClassContextOfFullBrowser
]

{ #category : 'accessing' }
SpPersistInstVarCommand >> defaultMenuItemName [
	^'Persist inst var…'
]

{ #category : 'execution' }
SpPersistInstVarCommand >> execute [
	| accessor varNames index |
	varNames := targetClass class instVarNames.
	index := UIManager default chooseFrom: varNames.
	index = 0
		ifTrue: [ ^ self ].
	accessor := varNames at: index.
	targetClass persist: accessor
]
