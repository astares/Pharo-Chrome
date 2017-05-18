utilities
sendMessage: aMessage

	| webSocket |
	webSocket := ZnWebSocket to: self webSocketDebuggerUrl.
	^[ webSocket 
  	  sendMessage: aMessage;
    	readMessage ] ensure: [ webSocket close ].