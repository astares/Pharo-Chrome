operations - page
captureScreenshot

	| base64 json |
	json := self sendMessage: {
        'method' -> 'Page.captureScreenshot'.
        'params' ->  { }
      } asDictionary.
	base64 := ((STON fromString: json) at: 'result') at: 'data'.
	
	^Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: base64 readStream) 