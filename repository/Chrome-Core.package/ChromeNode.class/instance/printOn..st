printing
printOn: aStream

	super printOn: aStream.
	aStream << '('.
	self nodeId printOn: aStream.
	aStream
		<< ' ';
		<< self nodeName;
		<< ')'