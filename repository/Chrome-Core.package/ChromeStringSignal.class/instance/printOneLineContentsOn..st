printing
printOneLineContentsOn: stream
	self category printOn: stream.
	stream tab.
	stream nextPutAll: self message