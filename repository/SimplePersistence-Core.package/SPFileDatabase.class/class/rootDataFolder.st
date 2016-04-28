accessing
rootDataFolder
	^ RootDataFolder ifNil: [ FileLocator imageDirectory ]