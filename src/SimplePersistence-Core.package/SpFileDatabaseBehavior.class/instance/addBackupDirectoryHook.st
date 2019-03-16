setting up
addBackupDirectoryHook

	| source |
	source := 
'backupDirectoryParent
	"Re-write this if you''d like your backups to be saved in a location other than the image folder"
	^ super backupDirectoryParent'.
	self databaseClass class compile: source classified: 'accessing'.