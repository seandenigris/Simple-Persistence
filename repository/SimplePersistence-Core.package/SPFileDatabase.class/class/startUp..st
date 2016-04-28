private
startUp: isComingUp 
	isComingUp ifTrue: [ self restoreLastBackup ]