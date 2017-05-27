initialize
initialize

	super initialize.
	loading := Bag new.
	stoppedLoading := Bag new.
	loadedTimestamp := nil.
	idleProcess := nil.
	pageLoadDelay := 2000.