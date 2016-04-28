as yet unclassified
create

	self
		addInitializer;
		addRepositoryAccessorFor: instVarName of: containerClass;
		addRestorationMethodFor: containerClass;
		addBackupDirectoryHook.