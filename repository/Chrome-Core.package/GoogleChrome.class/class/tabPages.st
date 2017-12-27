accessing
tabPages

	| remotes |
	remotes := STON fromString: (ZnEasy get: 'http://localhost:9222/json') contents.
	^(remotes select: [ :each | each includesKey: #webSocketDebuggerUrl])
		collect: [:each | ChromeTabPage fromDictionary: each ].