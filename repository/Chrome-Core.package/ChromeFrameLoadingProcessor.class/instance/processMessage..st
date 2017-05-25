messages
processMessage: aMessageDictionary

	frameId ifNil: 
		[ messageQueue add: aMessageDictionary ]
	ifNotNil: 
		[ self checkMessages: aMessageDictionary ]