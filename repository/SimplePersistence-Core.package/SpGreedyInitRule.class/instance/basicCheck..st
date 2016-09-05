running
basicCheck: aMethod
	Transcript show: aMethod methodClass name; cr.
	aMethod methodClass superclass = SpFileDatabase class 
		ifTrue: [ Halt once ]
		ifFalse: [ ^ false ].
	^ aMethod selector = #initialize and: [ aMethod ast sentMessages includes: #enablePersistence ]