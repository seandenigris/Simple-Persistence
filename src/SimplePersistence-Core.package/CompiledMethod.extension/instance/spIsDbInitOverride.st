*SimplePersistence-Core
spIsDbInitOverride

	^ self methodClass superclass = SpFileDatabase class and: [ self selector = #initialize ]