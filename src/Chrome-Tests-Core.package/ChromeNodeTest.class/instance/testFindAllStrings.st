tests
testFindAllStrings

	| page searchString stringNodes |

	page := GoogleChromeTestResource current page.
	searchString := 'Title One'.
	stringNodes := page rootNode findAllStrings: searchString.
	self assert: stringNodes size equals: 1.
	self assert: stringNodes first contents equals: searchString