tests
testPage1Document
	"Check that Page1 has loaded correctly"

	| page rootNode h1 a |

	page := GoogleChromeTestResource current page.
	page getDocument.
	rootNode := page rootNode.
	h1 := rootNode findAllTags: 'h1'.
	self assert: h1 children first contents equals: 'Title One'.
	a := rootNode findAllTags: 'a'.
	self assert: (a attributeAt: 'href') equals: 'http://pharo.org'.