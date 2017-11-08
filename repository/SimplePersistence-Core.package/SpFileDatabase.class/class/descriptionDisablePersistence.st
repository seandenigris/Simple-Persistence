Magritte
descriptionDisablePersistence
	<magritteActionDescription>
	
	^ MAActionDescription new
			action: #disablePersistence;
			enableBlock: [ :e | e isPersistenceEnabled ];
			yourself