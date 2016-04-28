as yet unclassified
baseline: spec
	<baseline>

	spec for: #common do: [
		spec description: 'Adapted from 3.0.1-baseline of ConfigurationOf from StHub repo'.
		spec 
			package: 'SimplePersistence-Core';
			package: 'SimplePersistence-Tests' with: [
				spec requires: #('SimplePersistence-Core' ). ].
		spec 
			group: 'Core' with: #('SimplePersistence-Core' ); 
			group: 'Tests' with: #('SimplePersistence-Tests');
			group: 'CI' with: #('Core' 'Tests');
			group: 'default' with: #('Core' ) ].
		
	spec for: #'pharo2.x' do: [
		spec 
			package: 'SimplePersistence-Core' with: [
				spec requires: #('SimplePersistence-Platform' ). ];
			package: 'SimplePersistence-Platform' with: 'SimplePersistence-Platform.pharo20'. ].
	
	  