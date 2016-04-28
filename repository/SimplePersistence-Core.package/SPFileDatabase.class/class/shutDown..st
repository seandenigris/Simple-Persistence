startup/shutdown
shutDown: isGoingDown 
	isGoingDown ifTrue: [ self saveRepository ]