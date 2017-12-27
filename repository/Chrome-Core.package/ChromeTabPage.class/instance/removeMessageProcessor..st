private
removeMessageProcessor: aMessageProcessor

	^messageProcessorMutex critical: 
		[ messageProcessors remove: aMessageProcessor ]