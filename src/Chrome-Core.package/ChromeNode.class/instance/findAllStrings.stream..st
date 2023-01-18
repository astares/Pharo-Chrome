finding strings
findAllStrings: anObject stream: aStream
	| findBlock |
	findBlock := self createFindStringBlock: anObject.
	self isString
			ifTrue: [(findBlock value: self) ifTrue: [aStream nextPut: self]]
			ifFalse:[ self childrenDo: [:ch | ch findAllStrings: anObject stream: aStream]]