private - operating
openURL: anURL
	"Open the requested URL.
	If there is an existing instance of Chrome that we can connect to, use that, if not, launch a new instance"
	| args retryCount version |

	[ self version ]
		on: ConnectionTimedOut
		do: [ :ex |
			args := String streamContents: [ :stream |
				userDataDir ifNotNil: [ 
					stream
						<< ' --user-data-dir=';
						<< userDataDir fullName ].
				self isInDebugMode 
					ifFalse: [ stream
									<< ' -- "';
									<< anURL;
									<< '"' ]
					ifTrue: [ stream
									<< ' --remote-debugging-port=';
									<< debugPort asString;
									<< ' "';
									<< anURL;
									<< '"' ] ].
			ChromePlatform current openChromeWith: args.
			"It can take a while for the browser to actually start.
			Ping the browser until we get a successfull response."
			retryCount := 10.
			[ version := self version ]
				on: ConnectionTimedOut
				do: [ :ex1 |
					retryCount > 0 ifTrue:
						[ retryCount := retryCount - 1.
						1 second wait.
						ex1 retry. ]
					ifFalse:
						[ ex1 pass ]
					].
		].