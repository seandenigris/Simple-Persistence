Magritte-actions
descriptionDisablePersistence
	"Disable while playing with #togglePersistence, which may replace me.
	<magritteActionDescription>"
	
	^ MAActionDescription new
			action: #disablePersistence;
			enableBlock: [ :e | e isPersistenceEnabled ];
			yourself