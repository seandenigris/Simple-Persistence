private
shutDown: isGoingDown 
	isGoingDown ifTrue: [ self saveRepository ]