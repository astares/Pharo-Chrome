enumerating
allChildrenDo: aBlock
	"Apply the argument on all descendants of the receiver"

	self children do: [ :child |
		aBlock value: child.
		child allChildrenDo: aBlock]