API
create

	self
		addInitializer;
		addRepositoryAccessorFor: instVarName of: containerClass;
		addRestorationMethodFor: containerClass;
		addBackupDirectoryHook;
		addSaveScript;
		addRestoreScript.