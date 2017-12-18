Magritte-actions
descriptionRestoreLastBackup
	<magritteActionDescription>
	
	^ MAActionDescription new
			action: #restoreLastBackup;
			label: 'Restore Last Backup';
			isMutator: false;
			shortcut: $r asShortcut;
			yourself