messages
processMessage: aMessageDictionary

	(aMessageDictionary at: 'id' ifAbsent: [nil]) = id ifFalse: [ ^self ].
	result := aMessageDictionary.
	semaphore signal