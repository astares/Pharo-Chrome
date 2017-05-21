operating
requestChildNodesAt: nodeId depth: depth

	^self sendMessage: ('\{
        "id": 5,
        "method": "DOM.requestChildNodes",
        "params": \{"nodeId": {1}, "depth": {2}}
      }' format: {nodeId. depth})