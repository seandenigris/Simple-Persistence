setting up
addRestorationMethodFor: aClass 

	| template source |
	template := 
'restoreRepositories: someRepositories

	{1} restoreFrom: someRepositories first.'.
	source := template format: { aClass name }.
	self databaseClass class compile: source.