registration
register: aBaselineOfClass
	"Set the main project. All other projects persisted by SimplePersistence will be in library-mode i.e. defer to the main project to handle saving and restoring. This is important to keep object graphs intact"
	self mainProjectName: (aBaselineOfClass class name allButFirst: 'BaselineOf' size)