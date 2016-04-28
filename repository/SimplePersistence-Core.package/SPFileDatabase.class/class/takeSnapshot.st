restoring
takeSnapshot
	"Motivation (vs. #restoreLastBackup): if you want a little extra snappiness and you're not worried about making the user wait for the flush to disk"
	[self saveRepository] forkAt: Processor userBackgroundPriority
		named: 'snapshot: ' , self class name