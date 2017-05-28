tests
testPage1Title
	"Check that the expected title is returned"

	| page |

	page := GoogleChromeTestResource current page.
	page updateTitle.
	self assert: page title equals: 'Pharo-Chrome Test Page'