setting up
addSaveScript

	| source |
	source := 
'saveRepository
	<script>
	^ super saveRepository'.
	self databaseClass class compile: source classified: 'loading/saving'.