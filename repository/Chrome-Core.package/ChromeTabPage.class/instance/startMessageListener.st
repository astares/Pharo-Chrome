private
startMessageListener
	"Start the page's message receiving and processing process."
	| messageString |

	messageListener := [ [ self isOpen ] whileTrue: 
		[ [ [ messageString := self webSocket readMessage.
			messageQueue add: messageString.
			ChromeStringSignal log: 'Received message: ', messageString category: 'Message Listener'.
			self processReceivedMessage: messageString]
			on: ConnectionTimedOut
			do: [ :ex | 
					ChromeStringSignal log: 'Message Listener, normal timeout' category: 'Message Listener'.
					ex retry ] ]
				on: ConnectionClosed 
				do: [ :ex | 
					ChromeStringSignal log: 'Message Listener, connection closed' category: 'Message Listener'.
					socketState := #closed.
					webSocket := nil ] ].
			ChromeStringSignal log: 'Message Listener: exiting' category: 'Message Listener'.
	] forkNamed: 'ChromeTabPage ', id printString.