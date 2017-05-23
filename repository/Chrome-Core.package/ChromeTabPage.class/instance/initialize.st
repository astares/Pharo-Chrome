initialize
initialize

	super initialize.
	messageId := 0.
	messageProcessors := OrderedCollection new.
	messageQueue := WaitfreeQueue new.