operating
inspectLoop

	[ [ true ] whileTrue: 
		[ [messageQueue add: self webSocket readMessage]
			on: ConnectionTimedOut
			do: [ :ex | ex retry ] ]
	] forkNamed: 'ChromeTabPage'.