testing
isTable
	"Answer a boolean indicating whether the receiver is a table"

	^self isTag and: [ self nodeName asLowercase = 'table' ]