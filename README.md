# SimplePersistence

## Motivation

Most applications are designed for small businesses with small amounts of data. Therefore *most applications will never have to scale* (i.e. become the next Twitter), so *a relational database is overkill*. However, persisting by simply saving the image is slow and error-prone. This simple (one class) framework saves only your model. The idea is to use it as long as you can get away with, which may be forever!

This repository carries on the original work by Ramon Leon ([@gnaritas](https://github.com/gnaritas)), which started as this [an enlightening blog post](http://onsmalltalk.com/simple-image-based-persistence-in-squeak/).

## Installation
```smalltalk
Metacello new
	baseline: 'SimplePersistence';
	repository: 'github://seandenigris/Simple-Persistence';
	load.
```

# Usage

1. Subclass `SpFileDatabase`.
1. Your SpFileDatabase subclass should respond to class-side `#schema` with a collection of client classes (i.e. for which we will be handling persistence). For example:
	```smalltalk
	MyProjectDB class>>#schema

		^ {
			QuQuote. "a domain class that is part of our project"
			LivingLibraryDB "the DB from another project (LivingLibraryDB sbclass), which we will take over and persist as part of our model."
		}.
	```
1. All client classes (i.e. `QuQuote` and `LivingLibraryDB` above) must respond to `#spData` with the data to be persisted. SpFileDatabase subclasses get this for free. Here's an example of a domain client class implementation:
	```smalltalk
	MyDomainClass class>>#spData
		^ { self uniqueInstance. self tags }
	```
1. All client classes must respond to `#restoreFrom:` taking the data they gave us to persist as the argument. Note that this is not an API change for domain classes, but now `SpFileDatabase` subclasses use the same message (which they get for free), instead of `#restoreRepositories:`. Here is an example for the domain class in the point above:
	```smalltalk
	MyDomainClass class>>#restoreFrom: aCollection
		uniqueInstance := aCollection first.
		tags := aCollection second.
	```

# Users
- [Living Library](https://github.com/seandenigris/Living-Library) - see `LivingLibraryDB`
- [My People](https://github.com/seandenigris/My-People) - see `MyPeopleDB`
- [Resources-Live](https://github.com/seandenigris/Resources-Live) - see `ResourcesLiveDB`
- [The Project Project](https://github.com/seandenigris/The-Project-Project) - see `TheProjectProjectDB`