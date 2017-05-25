private
checkMessage: aMessageDictionary

	| params completedFrameId |

	aMessageDictionary at: 'method' ifPresent:
		[ :method |
			method = 'Page.frameStoppedLoading' ifTrue:
				[
				params := aMessageDictionary at: 'params'.
				completedFrameId := params at: 'frameId'.
				completedFrameId = frameId ifTrue:
					[ semaphore signal ]
				].
			].