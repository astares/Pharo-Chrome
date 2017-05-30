finding strings
createFindStringBlock: anObject
	(anObject isKindOf: Boolean) ifTrue: [^ [:aTag | anObject]].
	anObject isString ifTrue: [^ [:aString | aString contents = anObject]].
	anObject isMatcher ifTrue: [^ [:aString | anObject search: aString contents]].
	anObject isCollection ifTrue: [^ [:aString | anObject includes: aString contents]].
	^ anObject