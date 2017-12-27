private
sendMessage: aDictionary
	"Send the supplied message to the browser, wait for the response and raise an exception on failure."

	^self sendMessage: aDictionary wait: true.