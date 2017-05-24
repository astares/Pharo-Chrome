operating
getDOM

	| result rootNode |
	"processor := ChromeSetChildNodeProcessor new."
	"self addMessageProcessor: processor."
	result := self sendMessageDictionary: ({
        'method' -> 'DOM.getDocument'
      } asDictionary).
	"processor  frameId: ((result at: 'result'))."
	"processor wait."
	self checkResponse: result.
	rootNode := (result at: 'result') at: 'root'.
	^GCDTNode fromDictionary: rootNode.