finding tags
findAllTags: anObject 
	| findBlock |
	findBlock := self createFindTagBlock: anObject.
	^ Array streamContents: [ :aStream |
		self findAllTags: findBlock stream: aStream ]