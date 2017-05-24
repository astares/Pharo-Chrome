accessing
webSocket

	^webSocket ifNil:
		[ webSocket := ZnWebSocket to: self webSocketDebuggerUrl.
		self startMessageListener.
		webSocket ]