private
ensureIdleTimer
	"Ensure that the idle timer is running.
	This method is called when frameId has completed loading and there are no other loading frames."

	idleProcess ifNotNil: [ ^self ].
	
	idleProcess := [ | done timeDiff frameLoaded |
		StringSignal log: 'Started idle timer'.
		done := false.
		[ done ] whileFalse:
			[ (Delay forMilliseconds: 500) wait.
			frameLoaded := stoppedLoading includes: frameId.
			StringSignal log: 'Idle: ', loadedTimestamp printString, ' frameLoaded: ', frameLoaded printString.
			(loadedTimestamp isNotNil and: [ frameLoaded ]) ifTrue: [
				timeDiff := (DateAndTime now - loadedTimestamp) asMilliSeconds.
				StringSignal log: 'timeDiff: ', timeDiff printString.
		 		timeDiff >= 2499 ifTrue:
					[ done := true.
					semaphore signal. ]
				]
			]
		] forkNamed: 'Chrome Idle Timer'