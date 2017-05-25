private
ensureIdleTimer
	"Ensure that the idle timer is running.
	This method is called when frameId has completed loading and there are no other loading frames."

	idleProcess ifNotNil: [ ^self ].
	
	idleProcess := [ | done timeDiff |
		done := false.
		[ done ] whileFalse:
			[ (Delay forMilliseconds: 500) wait.
			(loadedTimestamp isNotNil and: [ stoppedLoading includes: frameId ]) ifTrue: [
				timeDiff := (DateAndTime now - loadedTimestamp) asMilliSeconds.
		 		timeDiff >= 499 ifTrue:
					[ idleProcess := nil.
					done := true.
					semaphore signal. ]
				]
			]
		] forkNamed: 'Chrome Idle Timer'