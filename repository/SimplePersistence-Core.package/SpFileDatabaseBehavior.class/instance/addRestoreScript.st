setting up
addRestoreScript

	| source |
	source := 
'restoreLastBackup
	<script>
	^ super restoreLastBackup'.
	self databaseClass class compile: source classified: 'loading/saving'.