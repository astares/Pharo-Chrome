operating
inspectLoop

	[ [ true ] whileTrue: 
		[ [self processReceivedMessage: self webSocket readMessage]
			on: ConnectionTimedOut
			do: [ :ex | ex retry ] ]
	] forkNamed: 'ChromeTabPage'.