tests
testAttributeAt

	| page anchour |

	page := GoogleChromeTestResource current page.
	anchour := (page rootNode findAllTags: 'a') first.
	self assert: (anchour attributeAt: 'href')
			equals: 'http://pharo.org'.
	self should: [ anchour attributeAt: 'blah' ] raise: KeyNotFound