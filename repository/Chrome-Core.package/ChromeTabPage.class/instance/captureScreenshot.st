operating
captureScreenshot

	| base64 json |
	json := self sendMessage: '{
        "id": 1,
        "method": "Page.captureScreenshot",
        "params":  { }
      }'.
	base64 := ((STON fromString: json) at: 'result') at: 'data'.
	
	^Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: base64 readStream) 