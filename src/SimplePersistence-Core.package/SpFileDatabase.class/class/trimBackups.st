private
trimBackups
	| entries versionsToKeep |
	versionsToKeep := self defaultHistoryCount.
	entries := self backupFiles select: [ :e | e base = self name ].
	entries size < versionsToKeep ifTrue: [ ^ self ].
	((entries sort: [ :a :b | a extension asInteger < b extension asInteger ]) allButLast: versionsToKeep) 
		do: [ :entry | entry delete ].