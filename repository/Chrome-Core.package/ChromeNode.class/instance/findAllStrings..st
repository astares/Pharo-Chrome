finding strings
findAllStrings: anObject
	"Returns all the strings equal to the argument. Note that the argument can be a string, a Boolean, a regex or a collection of strings to match several elements"
	
	| block |
	block := self createFindStringBlock: anObject.
	^ Array streamContents: [ :aStream |
			self findAllStrings: block stream: aStream ]