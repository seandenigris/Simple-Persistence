startup/shutdown
startUp: isComingUp 
	isComingUp ifTrue: [ self restoreLastBackup ]