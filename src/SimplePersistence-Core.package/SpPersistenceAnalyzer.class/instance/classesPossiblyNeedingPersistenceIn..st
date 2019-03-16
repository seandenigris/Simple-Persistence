private-model
classesPossiblyNeedingPersistenceIn: packageCollection

	^ packageCollection inject: OrderedCollection new into: [ :col :p | | possPersistentClasses |
			possPersistentClasses := p definedClasses select: [ :c |
				c hasClassSideInstVars and: [ self noDbPersists: c ] ].
			col addAll: possPersistentClasses.
			col ].