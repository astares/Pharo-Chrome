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
				ChromeStringSignal log: 'start loading ', messageFrameId printString
					category: self class.
				].
			method = 'Page.frameStoppedLoading' ifTrue:
				[
				messageFrameId := params at: 'frameId'.
				loading remove: messageFrameId
					ifAbsent: [ StringSignal log: 'unable to remove ', messageFrameId printString ].
				stoppedLoading add: messageFrameId.
				ChromeStringSignal log: 'stop loading ', messageFrameId printString
					category: self class.
				].
			loading isEmpty ifTrue: 
				[
				loadedTimestamp := DateAndTime now.
				self ensureIdleTimer ]
			ifFalse:
				[ loadedTimestamp := nil ].
			ChromeStringSignal log: 'Updated loadedTimestamp: ', loadedTimestamp printString
				category: self class.
		].
