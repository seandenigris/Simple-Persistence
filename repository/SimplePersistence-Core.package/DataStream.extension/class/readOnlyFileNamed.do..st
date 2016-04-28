*SimplePersistence-Core
readOnlyFileNamed: aName do: aBlock 
    | file |
    file := self readOnlyFileNamed: aName.
    ^ file 
        ifNil: [ nil ]
        ifNotNil: [ [ aBlock value: file ] ensure: [ file close ] ]