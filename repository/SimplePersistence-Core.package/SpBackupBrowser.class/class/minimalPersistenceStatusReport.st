as yet unclassified
minimalPersistenceStatusReport
	<script>
	(self subclasses collect: [ :e | e -> e isPersistenceEnabled ]) asDictionary inspect