private
sendMessageString: aMessageString

	ChromeStringSignal log: aMessageString category: 'sendMessage:'.
	^self webSocket sendMessage: aMessageString