private
versionOf: backupFile
	^ (FileDirectory extensionFor: backupFile name) asInteger.