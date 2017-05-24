api - dom
getMissingChildren: rootNode

	| childless |
	childless := rootNode allSelect: [ :each | each childNodeCount > each children size ].
	childless do: [ :each | self requestChildNodesAt: each nodeId depth: 100 ].