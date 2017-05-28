operations - dom
getOuterHTML: nodeId

	^self sendMessage: {
        'method' -> 'DOM.getOuterHTML'.
        'params' -> {'nodeId' -> nodeId} asDictionary.
      } asDictionary.