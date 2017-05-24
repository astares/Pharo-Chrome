accessing
requestChildNodesAt: nodeId depth: depth

	| result processor |

	processor := ChromeSetChildNodeProcessor new.
	self addMessageProcessor: processor.
	result := self sendMessageDictionary: {
        'method' -> 'DOM.requestChildNodes'.
        'params' -> {'nodeId' -> nodeId. 'depth' -> depth} asDictionary
      } asDictionary.
	self checkResponse: result.
	processor wait.
	^result