private
startMessageListener

	[ [ self isOpen ] whileTrue: 
		[ [ [messageQueue add: self webSocket readMessage.
			self processReceivedMessage: messageQueue last]
			on: ConnectionTimedOut
			do: [ :ex | ex retry ] ]
				on: ConnectionClosed 
				do: [ :ex | webSocket := nil ] ].
	] forkNamed: 'ChromeTabPage ', id printString.