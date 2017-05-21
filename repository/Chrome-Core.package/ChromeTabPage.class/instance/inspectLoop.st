operating
inspectLoop

	[ [ true ] whileTrue: 
		[ [self webSocket readMessage inspect]
			on: ConnectionTimedOut
			do: [ :ex | 'Loop again' ] ]
	] forkNamed: 'ChromeTabPage'.