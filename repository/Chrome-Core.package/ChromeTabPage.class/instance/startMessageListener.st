private
startMessageListener
	"Start the page's message receiving and processing process."
	| messageString |

	messageListener := [ [ self isOpen ] whileTrue: 
		[ [ [ messageString := self webSocket readMessage.
			messageQueue add: messageString.
			ChromeStringSignal log: 'Received message: ', messageString category: self class.
			self processReceivedMessage: messageString]
			on: ConnectionTimedOut
			do: [ :ex | 
					ChromeStringSignal log: 'Message Listener, normal timeout' category: self class.
					ex retry ] ]
				on: ConnectionClosed 
				do: [ :ex | webSocket := nil ] ].
			ChromeStringSignal log: 'Message Listener: exiting' category: self class.
	] forkNamed: 'ChromeTabPage ', id printString.