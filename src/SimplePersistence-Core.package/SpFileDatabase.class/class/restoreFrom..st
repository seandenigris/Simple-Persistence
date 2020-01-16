restoring
restoreFrom: aDictionary
	"All client classes (i.e. that use me for persistence) must respond to this message. The argument (here aDictionary, but could be any type) is the data they gave me to persist"
	aDictionary keysAndValuesDo: [ :klass :data | klass restoreFrom: data ]