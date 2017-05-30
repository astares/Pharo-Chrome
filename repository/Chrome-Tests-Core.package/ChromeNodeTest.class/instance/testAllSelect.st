tests
testAllSelect

	| page textNodes texts |

	page := GoogleChromeTestResource current page.
	textNodes := page rootNode allSelect: [ :each |
		each nodeName = '#text' ].
	texts := textNodes collect: [ :each | each contents ].
	self assert: texts equals: #('Pharo-Chrome Test Page' 'Title One' 'Paragraph One' 'Go to Pharo.Org' ' with some more text').
