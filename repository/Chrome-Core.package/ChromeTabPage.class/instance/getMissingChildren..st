api - dom
getMissingChildren: rootNode

	| childless |
	childless := rootNode allSelect: [ :each | each childNodeCount > each children size ].
	childless do: [ :each | self requestChildNodesAt: each depth: 100 ].