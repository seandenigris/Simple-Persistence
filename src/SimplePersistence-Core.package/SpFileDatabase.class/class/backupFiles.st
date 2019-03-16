private
backupFiles

	^ self backupDirectory files select: [ :e | 
			(e basename beginsWith: self name) and: [ e extension isAllDigits ] ].