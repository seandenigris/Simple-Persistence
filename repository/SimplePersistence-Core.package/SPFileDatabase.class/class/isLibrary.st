testing
isLibrary
	^ self mainProjectName isNotNil and: [ self mainProjectName ~= self projectName ]