"
# Examples

Here's an example of a class persisting a class-side instance variable for its subclasses:

```
MyAbstractClass class>>#restoreFrom: anObject
	self = CwMacApplication
		ifTrue: [ self subclassesDo: [ :cls | cls restoreFrom: (anObject at: cls) ] ]
		ifFalse: [ installers := anObject ]
```

```
MyAbstractClass class>>#spData
	^ self = CwMacApplication
		ifTrue: [ 
			self subclasses 
				inject: Dictionary new 
				into: [ :dict :cls |
					dict 
						at: cls put: cls spData;
						yourself ] ]
		ifFalse: [ installers ]
```
"
Class {
	#name : #BaselineOfSimplePersistence,
	#superclass : #BaselineOf,
	#category : #BaselineOfSimplePersistence
}

{ #category : #baselines }
BaselineOfSimplePersistence >> baseline: spec [
	<baseline>

	spec for: #common do: [
		spec
			baseline: 'Magritte' with: [
				spec repository: 'github://seandenigris/Magritte' ];
			package: 'SimplePersistence-Core' ;
			package: 'SimplePersistence-Tests' with: [
				spec requires: #('SimplePersistence-Core' ). ].
		spec 
			group: 'Core' with: #('SimplePersistence-Core' ); 
			group: 'Tests' with: #('SimplePersistence-Tests');
			group: 'CI' with: #('Core' 'Tests');
			group: 'Browser' with: #('CI' 'Magritte');
			group: 'default' with: #('Tests' ) ].
		
	spec for: #'pharo2.x' do: [
		spec 
			package: 'SimplePersistence-Core' with: [
				spec requires: #('SimplePersistence-Platform' ). ];
			package: 'SimplePersistence-Platform' with: 'SimplePersistence-Platform.pharo20'. ].
	
	  
]
