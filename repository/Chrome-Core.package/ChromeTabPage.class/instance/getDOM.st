operating
getDOM

	| result rootNode |
	result := self sendMessageDictionary: ({
        'method' -> 'DOM.getDocument'
      } asDictionary).
	self checkResponse: result.
	rootNode := (result at: 'result') at: 'root'.
	^GCDTNode fromDictionary: rootNode.