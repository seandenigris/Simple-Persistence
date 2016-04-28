accessing
backupDirectory

	^ (FileLocator imageDirectory / self name) ensureDirectory.
