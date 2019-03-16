testing
isMainProject
	^ self mainProjectName isNotNil and: [ self mainProjectName = self projectName ]