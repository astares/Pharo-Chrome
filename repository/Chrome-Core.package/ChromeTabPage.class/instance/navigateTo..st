operating
navigateTo: anURL

	^self sendMessageDictionary: {
        '"method"' -> '"Page.navigate"'.
        '"params"' -> ('\{"url": "{1}"}' format: {anURL}).
		} asDictionary.