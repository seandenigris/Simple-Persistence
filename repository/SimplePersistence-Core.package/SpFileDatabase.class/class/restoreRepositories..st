override in subclasses
restoreRepositories: someRepositories
	"Put them back wherever they belong in the image for the application to use them."
	self subclassResponsibility