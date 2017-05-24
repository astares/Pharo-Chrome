operations - dom
getMissingChildren: rootNode

	| childless |
	childless := rootNode allSelect: [ :each | each childNodeCount > each children size ].
	[ childless notEmpty ] whileTrue:
		[ childless do: [ :each | self requestChildNodesAt: each depth: 100 ].
		childless := rootNode allSelect: [ :each | each childNodeCount > each children size ] ].