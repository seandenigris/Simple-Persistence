private
backupVersion: aNumber
	| backup |
	backup := self backupFileForVersion: aNumber.
	backup ifNil: [ ^ nil ].
	^ ReferenceStream 
		readOnlyFileNamed: backup fullName
		do: [ : f | f next ]