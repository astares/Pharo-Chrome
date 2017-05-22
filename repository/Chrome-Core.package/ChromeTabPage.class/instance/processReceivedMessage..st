private
processReceivedMessage: aMessageString

	| ston |
	
	ston := STON fromString: aMessageString.
	self halt.
	messageProcessors do: [ :each | each processMessage: ston ]