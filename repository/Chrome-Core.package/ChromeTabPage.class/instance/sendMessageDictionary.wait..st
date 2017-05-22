operating
sendMessageDictionary: aDictionary wait: waitBoolean

	| result processor mid |

	"Ensure that a message id is included"
	mid := aDictionary at: 'id' ifAbsentPut: [self nextMessageId].
	"If waiting, set up the message processor to signal on completion"
	waitBoolean ifTrue: [ 
		processor := ChromeStatusMessageProcessor forMessageId: mid.
		self addMessageProcessor: processor ].
	"Send the message"
	result := self sendMessage: (STON toJsonString: aDictionary).
	"If requested, wait for operation completion"
	waitBoolean ifTrue: [
		processor wait.
		self checkResponse: processor result.
		self removeMessageProcessor: processor. ].
	^result