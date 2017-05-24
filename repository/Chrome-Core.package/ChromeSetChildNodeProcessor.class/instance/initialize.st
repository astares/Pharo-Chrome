initialize
initialize

	super initialize.
	startedFrames := Bag new.
	loadedFrames := Bag new.
	semaphore := Semaphore new.