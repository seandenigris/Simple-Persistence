protocol
materializeFrom: aFileReference

	^ ReferenceStream 
			readOnlyFileNamed: aFileReference fullName
			do: [ : f | f next ].