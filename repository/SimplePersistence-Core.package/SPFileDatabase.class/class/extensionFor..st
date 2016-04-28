private
extensionFor: aDirectoryEntryFile
	
	self flag: 'This should be in DirectoryEntryFile, but Pharo 1.4 will have FS and is not accepting fixes to FileDirectory and friends. Squeak 4.2 has DirectoryEntry>>extension, so when 1.4 is released, we can split out platform packages and replace this with the appropriate calls for each fork'.

	^ FileDirectory extensionFor: aDirectoryEntryFile name.