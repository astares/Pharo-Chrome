private
ensureIdleTimer
	"Ensure that the idle timer is running.
	This method is called when frameId has completed loading and there are no other loading frames."

	idleProcess ifNotNil: [ ^self ].
	
	idleProcess := [ | done timeDiff frameLoaded |
		ChromeIdleTimerSignal new
			message: 'Started idle timer';
			emit.
		done := false.
		[ done ] whileFalse:
			[ (Delay forMilliseconds: 500) wait.
			frameLoaded := stoppedLoading includes: frameId.
			ChromeIdleTimerSignal new
				message: 'Checking';
				loadedTimestamp: loadedTimestamp;
				frameLoaded: frameLoaded;
				emit.
			(loadedTimestamp isNotNil and: [ frameLoaded ]) ifTrue: [
				timeDiff := (DateAndTime now - loadedTimestamp) asMilliSeconds.
				ChromeIdleTimerSignal new 
					message: 'timeDiff';
					timeDiff: timeDiff;
					emit.
		 		timeDiff >= pageLoadDelay ifTrue:
					[ done := true.
					ChromeIdleTimerSignal new
						message: 'Signalling';
						emit.
					semaphore signal. ]
				]
			].
		ChromeIdleTimerSignal new 
			message: 'Idle Timer Done';
			emit.
		] forkNamed: 'Chrome Idle Timer'