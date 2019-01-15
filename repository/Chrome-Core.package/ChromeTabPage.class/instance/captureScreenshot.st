operations - page
captureScreenshot

	| base64 json layout clip |
	layout := self getLayoutMetrics.
	clip := { 
		'x' -> 0.
		'y' -> 0.
		'width' -> ((layout at: 'contentSize') at: 'width').
		'height' -> ((layout at: 'contentSize') at: 'height').
		'scale' -> 1.0. } asDictionary.
	json := self sendMessage: {
        'method' -> 'Page.captureScreenshot'.
        'params' -> { 'clip' -> clip } asDictionary.
      } asDictionary.
	base64 := (json at: 'result') at: 'data'.
	
	^Form fromBinaryStream: base64 base64Decoded readStream