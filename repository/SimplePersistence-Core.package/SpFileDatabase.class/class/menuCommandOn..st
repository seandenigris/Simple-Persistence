*SimplePersistence-Core-Developer
menuCommandOn: aBuilder 
	<worldMenu> 
	
	(aBuilder item: #'Simple Persistence')
		with: [
			(aBuilder item: #'Backup Browser')
				action: [ self backupBrowser ]; 
				icon: Smalltalk ui icons glamourousTable. ]