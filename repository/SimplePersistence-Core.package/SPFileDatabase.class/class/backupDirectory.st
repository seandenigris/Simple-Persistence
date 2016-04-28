override in subclasses
backupDirectory

	^ (FileLocator imageDirectory / self name) ensureDirectory.
