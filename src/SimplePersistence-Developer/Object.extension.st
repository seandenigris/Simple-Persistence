Extension { #name : #Object }

{ #category : #'*SimplePersistence-Developer' }
Object >> persistIn: aClass as: aSymbol [
	"This is the main entry point to set up for persistence. It creates the database class for the package with all necessary methods, and the required methods in the domain class that holds the persistence object.
	aClass - will hold this object in a class inst var
	aSymbol - the name of that inst var
	"

	aClass persist: aSymbol.
]
