override in subclasses
trimBackups
	| entries versionsToKeep |
	versionsToKeep := self defaultHistoryCount.
	entries := self backupDirectory files select: [ :e | e base = self name ].
	entries size < versionsToKeep ifTrue: [ ^ self ].
	((entries sortBy: [ :a :b | a extension asInteger < b extension asInteger ]) allButLast: versionsToKeep) 
		do: [ :entry | entry delete ].