enumerating
detect: aBlock ifFound: foundBlock ifNone: execptionBlock
	"Detect the node matching aBlock.  Any child nodes are also searched."

	(aBlock value: self) ifTrue: [ ^foundBlock cull: self ].
	self allChildrenDo: [ :each |
		(aBlock value: each) ifTrue: [ ^foundBlock cull: each ] ].
	^execptionBlock value