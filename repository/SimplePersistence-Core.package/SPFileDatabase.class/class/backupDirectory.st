override in subclasses
backupDirectory

	^ (FileLocator imageDirectory / self backupDirectoryName) ensureDirectory.
