tests
testPage1Title
	"Check that the expected title is returned"

	| page |

	page := GoogleChromeTestResource current page.
	self assert: page title equals: 'Pharo-Chrome Test Page'