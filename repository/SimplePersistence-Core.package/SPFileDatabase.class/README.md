Based on the idea that:
* most applications will not have to scale (i.e. become the next Twitter)
* simply saving the image is slow and error-prone

For the full motivation, see Ramon Leon's blog post at http://onsmalltalk.com/simple-image-based-persistence-in-squeak/.

To give your application persistence:
	1. Subclass SMFileDatabase
	2. On the subclass, implement:
		a. class>>repositories (see method comment).
		b. class>>restoreRepositories: (see method comment).
		
That's it! Now, whenever you want to save, call class>>saveRepository or class>>takeSnapshot (background save).

To customize:
* Number of backups kept: override class>>defaultHistoryCount
			