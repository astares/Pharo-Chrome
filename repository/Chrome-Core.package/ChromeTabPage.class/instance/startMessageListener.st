private
startMessageListener
	"Start the page's message receiving and processing process."
	| messageString |

	[ [ self isOpen ] whileTrue: 
		[ [ [ messageString := self webSocket readMessage.
			messageQueue add: messageString.
			self processReceivedMessage: messageString]
			on: ConnectionTimedOut
			do: [ :ex | ex retry ] ]
				on: ConnectionClosed 
				do: [ :ex | webSocket := nil ] ].
	] forkNamed: 'ChromeTabPage ', id printString.