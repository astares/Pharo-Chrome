messages
processMessage: aMessageDictionary

	self halt.
	aMessageDictionary at: 'result' ifPresent: 
		[ :result | rootNode := GCDTNode fromDictionary: (result at: 'root') ].
