private
webSocket

	^webSocket ifNil: [ webSocket := ZnWebSocket to: self webSocketDebuggerUrl ]