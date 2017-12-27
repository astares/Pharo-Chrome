operations - dom
getDocument

	| result |
	result := self sendMessage: ({
        'method' -> 'DOM.getDocument'
      } asDictionary).
	self checkResponse: result.
	rootNode := ChromeNode fromDictionary: ((result at: 'result') at: 'root') parent: nil.
	^rootNode