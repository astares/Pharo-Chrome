tests
testAttributeAtIfAbsent

	| page anchour |

	page := GoogleChromeTestResource current page.
	anchour := (page rootNode findAllTags: 'a') first.
	self assert: (anchour attributeAt: 'href' ifAbsent: [ false ]) 
			equals: 'http://pharo.org'.
	self assert: (anchour attributeAt: 'blah' ifAbsent: [ true ]).