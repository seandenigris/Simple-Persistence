*SimplePersistence-Core-Developer
showPersistenceStatusReport
	<script>
	(self subclasses collect: [ :e | e -> e isPersistenceEnabled ]) asDictionary inspect