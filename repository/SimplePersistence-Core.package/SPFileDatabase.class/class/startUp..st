system startup
startUp: isComingUp 
	isComingUp ifTrue: [ self restoreLastBackup ]