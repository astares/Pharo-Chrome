operations - page
navigateTo: anURL

	^self sendMessageDictionary: {
        'method' -> 'Page.navigate'.
        'params' -> { 'url' -> anURL } asDictionary.
		} asDictionary.