printing
printOneLineContentsOn: stream
	stream nextPutAll: self message.
	loadedTimestamp ifNotNil: 
		[ stream nextPutAll: ' lT: '.
		loadedTimestamp printOn: stream. ].
	frameLoaded ifNotNil: 
		[ stream nextPutAll: ' fL: '.
		frameLoaded printOn: stream ].
	timeDiff ifNotNil: 
		[ stream nextPutAll: 'tD: '.
		timeDiff printOn: stream ].