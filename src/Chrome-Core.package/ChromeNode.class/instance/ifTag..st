testing
ifTag: aBlock
	"Evaluate aBlock if the receiver is a tag"

	^self isTag ifTrue: [ aBlock value ]