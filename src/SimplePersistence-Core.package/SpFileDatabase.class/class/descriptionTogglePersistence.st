Magritte-actions
descriptionTogglePersistence
	<magritteActionDescription>
	
	^ MAActionDescription new
			action: #togglePersistence;
			label: 'Toggle Persistence';
			isMutator: true;
			shortcut: $t asShortcut;
			yourself