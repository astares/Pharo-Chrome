private
startMessageListener
	"Start the page's message receiving and processing process."
	| messageString |

	messageListener := [ [ self isOpen ] whileTrue: 
		[ [ [ messageString := self webSocket readMessage.
			messageQueue add: messageString.
			ChromeMessageListenerSignal log: 'Received message: ', messageString.
			self processReceivedMessage: messageString]
			on: ConnectionTimedOut
			do: [ :ex | 
					ChromeMessageListenerSignal log: 'Message Listener, normal timeout'.
					ex retry ] ]
				on: ConnectionClosed 
				do: [ :ex | webSocket := nil ] ].
			ChromeMessageListenerSignal log: 'Message Listener: exiting'.
	] forkNamed: 'ChromeTabPage ', id printString.