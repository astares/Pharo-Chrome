messages
processMessage: aMessageDictionary

	self halt.
	aMessageDictionary at: 'result' ifPresent: 
		[ :result | 
			result at: 'root' ifPresent:
				[ :root | rootNode := GCDTNode fromDictionary: root ].
			result at: 'frameId' ifPresent:
				[ :fid | frameId := fid ] ].
	aMessageDictionary at: 'method' ifPresent:
		[ :method |
			method = 'Page.frameStartedLoading' ifTrue:
				[ startedFrames add: ((aMessageDictionary at: 'params') at: 'frameId') ].
			method = 'Page.frameStoppedLoading' ifTrue:
				[ loadedFrames add: ((aMessageDictionary at: 'params') at: 'frameId') ].
			].