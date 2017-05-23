operating
inspectLoop

	[ [ true ] whileTrue: 
		[ [messageQueue nextPut: self webSocket readMessage]
			on: ConnectionTimedOut
			do: [ :ex | ex retry ] ]
	] forkNamed: 'ChromeTabPage'.