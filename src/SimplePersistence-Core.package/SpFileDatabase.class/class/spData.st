accessing
spData
	"All client classes (i.e. that use me for persistence) must respond to this message with the data to be persisted"
	^ self schema
		inject: Dictionary new
		into: [ :dict :klass | dict at: klass put: klass spData; yourself ]