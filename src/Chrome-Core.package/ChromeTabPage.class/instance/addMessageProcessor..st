private
addMessageProcessor: aMessageProcessor

	^messageProcessorMutex critical:
		[ messageProcessors add: aMessageProcessor ]