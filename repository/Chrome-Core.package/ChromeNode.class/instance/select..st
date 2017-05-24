enumerating
select: aBlock
	"Like Collection>>select:, answer a collection of nodes for which aBlock returns true.
	Note that this method assumes all child nodes have been retrieved from Chrome."
	
	| newCollection |
	
	newCollection := OrderedCollection new.
	(aBlock value: self) ifTrue: [ newCollection add: self ].
	self childrenDo: [ :each | (aBlock value: each) ifTrue: 
			[ newCollection add: each ] ].
	^newCollection