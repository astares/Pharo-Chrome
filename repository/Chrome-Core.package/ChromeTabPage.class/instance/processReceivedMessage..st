private
processReceivedMessage: aMessageString
	"Process the supplied message by passing it on to each of the current processors"
	| ston |
	
	ston := STON fromString: aMessageString.
	messageProcessors do: [ :each | each processMessage: ston ]