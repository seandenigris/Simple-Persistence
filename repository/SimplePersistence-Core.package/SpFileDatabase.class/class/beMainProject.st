registration
beMainProject
	| projectName |
	projectName := self name allButLast: 'DB' size.
	self mainProjectName: projectName