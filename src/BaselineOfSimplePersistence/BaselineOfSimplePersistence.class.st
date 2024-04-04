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
			package: 'SimplePersistence-Core' with: [
				spec requires: #("'Magritte'" "for browser"). ];
			package: 'SimplePersistence-Tests' with: [
				spec requires: #('SimplePersistence-Core' ). ];
			package: 'SimplePersistence-Developer' with: [
				spec requires: #('SimplePersistence-Tests' 'SimplePersistence-UI'  ). ];
			package: 'SimplePersistence-UI' with: [
				spec requires: #('Magritte' ). ].
		spec 
			group: 'Core' with: #('SimplePersistence-Core' ); 
			group: 'Tests' with: #('SimplePersistence-Tests');
			group: 'CI' with: #('Core' 'Tests');
			group: 'Dev' with: #('SimplePersistence-Developer');
			group: 'default' with: #('Core' ) ].
		
	spec for: #'pharo2.x' do: [
		spec 
			package: 'SimplePersistence-Core' with: [
				spec requires: #('SimplePersistence-Platform' ). ];
			package: 'SimplePersistence-Platform' with: 'SimplePersistence-Platform.pharo20'. ].
	
	  

]
