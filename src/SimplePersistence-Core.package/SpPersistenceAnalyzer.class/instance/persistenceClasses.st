private-model
persistenceClasses

	^ self packages inject: OrderedCollection new into: [ :col :p | | dbs |
		dbs := p definedClasses select: [ :c | c includesBehavior: SpFileDatabase ].
		col addAll: dbs.
		col ].