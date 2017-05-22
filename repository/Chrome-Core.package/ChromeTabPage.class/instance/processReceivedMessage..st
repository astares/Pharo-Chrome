private
processReceivedMessage: aMessageString

	| ston |
	
	ston := STON fromString: aMessageString.
	messageProcessors do: [ :each | each processMessage: ston ]