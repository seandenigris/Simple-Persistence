as yet unclassified
beMainProject
	| projectName |
	projectName := self name allButLast: 'DB' size.
	self mainProjectName: projectName