operating
getDOM

	| result processor |
	processor := ChromeSetChildNodeProcessor new.
	self addMessageProcessor: processor.
	result := self sendMessageDictionary: ({
        'method' -> 'DOM.getDocument'
      } asDictionary).
	processor  frameId: ((result at: 'result')).
	processor wait.