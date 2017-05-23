enumerating
detect: aBlock ifFound: foundBlock ifNone: execptionBlock
	"Detect the node matching aBlock.  Any child nodes are also searched."

	(aBlock value: self) ifTrue: [ ^foundBlock cull: self ].
	self childrenDo: [ :each |
		each detect: aBlock ifFound: [ :node | ^foundBlock cull: node ] ].
	^execptionBlock value.