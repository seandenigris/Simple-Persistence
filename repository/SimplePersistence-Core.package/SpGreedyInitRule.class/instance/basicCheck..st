running
basicCheck: aMethod
	
	aMethod spIsDbInitOverride ifFalse: [ ^ false ].
	^ aMethod ast sentMessages includes: #enablePersistence