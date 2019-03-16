private
togglePersistence
	self isPersistenceEnabled
		ifTrue: [ self disablePersistence ]
		ifFalse: [ self enablePersistence ]