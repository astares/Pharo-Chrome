messages
processMessage: aMessageDictionary

	| params messageFrameId |

	aMessageDictionary at: 'method' ifPresent:
		[ :method |
			params := aMessageDictionary at: 'params'.
			method = 'Page.frameStartedLoading' ifTrue:
				[
				messageFrameId := params at: 'frameId'.
				loading add: messageFrameId.
				StringSignal log: 'start loading ', messageFrameId printString.
				].
			method = 'Page.frameStoppedLoading' ifTrue:
				[
				messageFrameId := params at: 'frameId'.
				loading remove: messageFrameId
					ifAbsent: [ StringSignal log: 'unable to remove ', messageFrameId printString ].
				stoppedLoading add: messageFrameId.
				StringSignal log: 'stop loading ', messageFrameId printString.
				].
			loading isEmpty ifTrue: 
				[ loadedTimestamp := DateAndTime now.
				self ensureIdleTimer ]
			ifFalse:
				[ loadedTimestamp := nil ].
		].
