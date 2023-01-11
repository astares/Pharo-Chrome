initialize
initialize

	super initialize.
	messageId := 0.
	messageProcessors := OrderedCollection new.
	messageProcessorMutex := Mutex new.
	messageQueue := OrderedCollection new.
	pageLoadDelay := 2000.
	socketState := #closed.
	webSocket := nil