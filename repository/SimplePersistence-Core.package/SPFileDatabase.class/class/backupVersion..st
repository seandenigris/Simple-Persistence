private
backupVersion: aNumber
	| backup |
	backup := self backupFileForVersion: aNumber.
	backup ifNil: [ ^ nil ].
	^ self serializer materializeFrom: backup.