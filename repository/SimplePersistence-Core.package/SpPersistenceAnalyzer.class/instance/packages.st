private-model
packages

	self flag: 'hard code to bootstrap'.
	^ RPackage organizer packages select: [ :e | e name beginsWith: 'TradeMaster' ].