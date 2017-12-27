tests
testAllSelect

	| page textNodes texts |

	page := GoogleChromeTestResource current page.
	textNodes := page rootNode allSelect: [ :each |
		each nodeName = '#text' ].
	texts := textNodes collect: [ :each | each contents ].
	self assert: texts equals: #('Pharo-Chrome Test Page' 'Title One' 'Paragraph One' 'Go to Pharo.Org' ' with some more text' 'Test Tables' 'Col 1' 'Col 2' 'Cell 11' 'Cell 21' 'Cell 12' 'Cell 22' 'Col 1' 'Col 2' 'Col 3' 'Cell 11' 'Cell 21' 'Cell 12' 'Cell 22' 'Cell 23' ).
