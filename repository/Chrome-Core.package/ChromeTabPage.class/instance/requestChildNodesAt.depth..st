operations - dom
requestChildNodesAt: rootNode depth: depth

	| result processor |

	processor := ChromeSetChildNodeProcessor rootNode: rootNode.
	self addMessageProcessor: processor.
	result := self sendMessageDictionary: {
        'method' -> 'DOM.requestChildNodes'.
        'params' -> {'nodeId' -> rootNode nodeId. 'depth' -> depth} asDictionary
      } asDictionary.
	self checkResponse: result.
	processor wait.
	self removeMessageProcessor: processor.
	^result