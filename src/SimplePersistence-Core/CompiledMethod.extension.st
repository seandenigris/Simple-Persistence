Extension { #name : 'CompiledMethod' }

{ #category : '*SimplePersistence-Core' }
CompiledMethod >> spIsDbInitOverride [

	^ self methodClass superclass = SpFileDatabase class and: [ self selector = #initialize ]
]
