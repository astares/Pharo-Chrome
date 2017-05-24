messages
processMessage: aMessageDictionary

	| params parentId newNodes |

	aMessageDictionary at: 'method' ifPresent:
		[ :method |
			method = 'Page.frameStartedLoading' ifTrue:
				[ startedFrames add: ((aMessageDictionary at: 'params') at: 'frameId') ].
			method = 'Page.frameStoppedLoading' ifTrue:
				[ loadedFrames add: ((aMessageDictionary at: 'params') at: 'frameId') ].
			method = 'DOM.setChildNodes' ifTrue:
				[ params := aMessageDictionary at: 'params'.
				parentId := params at: 'parentId'.
				newNodes := params at: 'nodes'.
				parentId = rootNode nodeId ifTrue:
					[ rootNode children: (rootNode children, newNodes).
					semaphore signal ].
				].
			].