operations - dom
getDocument

	| result rootNode |
	result := self sendMessageDictionary: ({
        'method' -> 'DOM.getDocument'
      } asDictionary).
	self checkResponse: result.
	rootNode := (result at: 'result') at: 'root'.
	^ChromeNode fromDictionary: rootNode parent: nil.