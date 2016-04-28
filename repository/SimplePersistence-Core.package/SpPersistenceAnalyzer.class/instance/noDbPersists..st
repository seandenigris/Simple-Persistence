private-model
noDbPersists: aClass 

	^ self persistenceClasses noneSatisfy: [ :db | db persists: aClass ].