tests
testAllChildrenDo

	| page count |

	page := GoogleChromeTestResource current page.
	"Count the total number of children of the root node"
	count := 0.
	page rootNode allChildrenDo: [ :each | count := count + 1 ].
	self assert: count equals: 14.
