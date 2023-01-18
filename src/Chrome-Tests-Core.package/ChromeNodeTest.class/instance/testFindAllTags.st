tests
testFindAllTags

	| page tagNodes |

	page := GoogleChromeTestResource current page.
	tagNodes := page rootNode findAllTags: 'title'.
	self assert: tagNodes size equals: 1.
	self assert: tagNodes first children size equals: 1.
	self assert: tagNodes first children first contents equals: 'Pharo-Chrome Test Page'