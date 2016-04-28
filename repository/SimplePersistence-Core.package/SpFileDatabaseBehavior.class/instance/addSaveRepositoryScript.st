setting up
addSaveRepositoryScript
	"Enable click-icon-to-run in Pharo browser. An experiment with Magritte actions might be interesting for the same feature in an inspector"

	| source |
	source := 
'saveRepository
	<script>
	^ super saveRepository'.
	self databaseClass class compile: source classified: 'loading/saving'.