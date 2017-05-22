messages
processMessage: aMessageDictionary

	(aMessageDictionary at: 'id') = id ifFalse: [ ^self ].
	result := aMessageDictionary.
	semaphore signal