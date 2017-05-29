tests
testPage1Document
	"Check that Page1 has loaded correctly"

	| page rootNode h1 a |

	page := GoogleChromeTestResource current page.
	rootNode := page rootNode.
	h1 := rootNode findAllTags: 'h1'.
	self assert: h1 isNotEmpty description: 'Failed to find expected heading node'.
	self assert: h1 size equals: 1.
	h1 := h1 first.
	self assert: h1 children first contents equals: 'Title One'.
	a := rootNode findAllTags: 'a'.
	self assert: a isNotEmpty description: 'Failed to find expected anchour node'.
	self assert: a size equals: 1.
	a := a first.
	self assert: (a attributeAt: 'href') equals: 'http://pharo.org'.