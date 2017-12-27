finding tags
createFindTagBlock: anObject
	(anObject isKindOf: Boolean) ifTrue: [^ [:aTag | anObject]].
	anObject isString ifTrue: [^ [:aTag | aTag name = anObject]].
	anObject isCollection ifTrue: [^ [:aTag | anObject includes: aTag name]].
	^ anObject
