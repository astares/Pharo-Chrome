finding tags
findAllTags: anObject stream: aStream
	| findBlock |
	findBlock := self createFindTagBlock: anObject.
	self childTagsDo: [ :aTag |
			(findBlock value: aTag) ifTrue: [aStream nextPut: aTag].
			aTag findAllTags: findBlock stream: aStream ].