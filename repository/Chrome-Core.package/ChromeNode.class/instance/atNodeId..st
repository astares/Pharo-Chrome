accessing
atNodeId: anInteger
	"Answer the requested node"

	^self detect: [ :each | each nodeId = anInteger ]