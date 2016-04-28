system startup
shutDown: isGoingDown 
	isGoingDown ifTrue: [ self saveRepository ]