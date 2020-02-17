private
ensureIdleTimer
	"Ensure that the idle timer is running.
	This method is called when frameId has completed loading and there are no other loading frames."

	idleProcess ifNotNil: [ ^self ].
	
	idleProcess := [ | done timeDiff frameLoaded |
		done := false.
		[ done ] whileFalse:
			[ (Delay forMilliseconds: 500) wait.
			frameLoaded := stoppedLoading includes: frameId.
		 
			(loadedTimestamp isNotNil and: [ frameLoaded ]) ifTrue: [
				timeDiff := (DateAndTime now - loadedTimestamp) asMilliSeconds.
				 
		 		timeDiff >= pageLoadDelay ifTrue:
					[ done := true.					 
					 semaphore signal. ]
				]
			].
		] forkNamed: 'Chrome Idle Timer'