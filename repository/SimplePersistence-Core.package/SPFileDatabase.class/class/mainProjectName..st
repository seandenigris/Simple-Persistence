accessing
mainProjectName: anObject
	"The first one here gets to be the main project!"
	MainProjectName ifNil: [ MainProjectName := anObject ]