private
backupDirectory

	^ (FileLocator imageDirectory / self name) ensureDirectory.
