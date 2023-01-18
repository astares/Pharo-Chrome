finding tags
childTagsDo: aBlock
	"Apply the arguments on the direct tag elements of the receiver"

	self childrenDo: [ :anElement |
		anElement ifTag: [aBlock value: anElement] ]