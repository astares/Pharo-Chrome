private - operating
openURL: anURL
	| args retryCount version |
	args := self isInDebugMode 
					ifFalse: [ '-- ', anURL ]
					ifTrue: [ '--remote-debugging-port=',debugPort asString,' ',anURL ].
	ChromePlatform current openChromeWith: args.
	"It can take a while for the browser to actually start.
	Ping the browser until we get a successfull response."
	retryCount := 10.
	[ version := self version ]
		on: ConnectionTimedOut
		do: [ :ex |
			retryCount > 0 ifTrue:
				[ retryCount := retryCount - 1.
				1 second wait.
				ex retry. ]
			ifFalse:
				[ ex pass ]
			].
