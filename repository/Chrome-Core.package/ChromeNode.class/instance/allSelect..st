enumerating
allSelect: aBlock
	"Like Collection>>select:, answer an array of nodes for which aBlock returns true.
	Note that this method assumes all child nodes have been retrieved from Chrome."

	^Array streamContents: [ :stream |
		(aBlock value: self) ifTrue: [ stream nextPut: self ].
		self allChildrenDo: [ :each | (aBlock value: each) ifTrue:
			[ stream nextPut: each ] ].
		]