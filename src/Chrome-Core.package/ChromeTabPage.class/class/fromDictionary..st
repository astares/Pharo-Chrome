instance creation
fromDictionary: aDictionary

	^(self new)
		id: (aDictionary at: #id);
		type: (aDictionary at: #type);
		title: (aDictionary at: #title);
		description: (aDictionary at: #description);
		url: (aDictionary at: #url);
		webSocketDebuggerUrl: (aDictionary at: #webSocketDebuggerUrl);
		devtoolsFrontendUrl: (aDictionary at: #devtoolsFrontendUrl);
		yourself