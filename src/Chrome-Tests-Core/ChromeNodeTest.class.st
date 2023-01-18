Class {
	#name : #ChromeNodeTest,
	#superclass : #TestCase,
	#category : 'Chrome-Tests-Core-Nodes'
}

{ #category : #resources }
ChromeNodeTest class >> resources [

	^{ GoogleChromeTestResource }
]

{ #category : #tests }
ChromeNodeTest >> testAllChildrenDo [

	| page count |

	page := GoogleChromeTestResource current page.
	"Count the total number of children of the root node"
	count := 0.
	page rootNode allChildrenDo: [ :each | count := count + 1 ].
	self assert: count equals: 54
]

{ #category : #tests }
ChromeNodeTest >> testAllSelect [

	| page textNodes texts |

	page := GoogleChromeTestResource current page.
	textNodes := page rootNode allSelect: [ :each |
		each nodeName = '#text' ].
	texts := textNodes collect: [ :each | each contents ].
	self assert: texts equals: #('Pharo-Chrome Test Page' 'Title One' 'Paragraph One' 'Go to Pharo.Org' ' with some more text' 'Test Tables' 'Col 1' 'Col 2' 'Cell 11' 'Cell 21' 'Cell 12' 'Cell 22' 'Col 1' 'Col 2' 'Col 3' 'Cell 11' 'Cell 21' 'Cell 12' 'Cell 22' 'Cell 23' )
]

{ #category : #tests }
ChromeNodeTest >> testAttributeAt [

	| page anchour |

	page := GoogleChromeTestResource current page.
	anchour := (page rootNode findAllTags: 'a') first.
	self assert: (anchour attributeAt: 'href')
			equals: 'http://pharo.org'.
	self should: [ anchour attributeAt: 'blah' ] raise: KeyNotFound
]

{ #category : #tests }
ChromeNodeTest >> testAttributeAtIfAbsent [

	| page anchour |

	page := GoogleChromeTestResource current page.
	anchour := (page rootNode findAllTags: 'a') first.
	self assert: (anchour attributeAt: 'href' ifAbsent: [ false ])
			equals: 'http://pharo.org'.
	self assert: (anchour attributeAt: 'blah' ifAbsent: [ true ])
]

{ #category : #tests }
ChromeNodeTest >> testFindAllStrings [

	| page searchString stringNodes |

	page := GoogleChromeTestResource current page.
	searchString := 'Title One'.
	stringNodes := page rootNode findAllStrings: searchString.
	self assert: stringNodes size equals: 1.
	self assert: stringNodes first contents equals: searchString
]

{ #category : #tests }
ChromeNodeTest >> testFindAllTags [

	| page tagNodes |

	page := GoogleChromeTestResource current page.
	tagNodes := page rootNode findAllTags: 'title'.
	self assert: tagNodes size equals: 1.
	self assert: tagNodes first children size equals: 1.
	self assert: tagNodes first children first contents equals: 'Pharo-Chrome Test Page'
]

{ #category : #tests }
ChromeNodeTest >> testTableData [

	| page tables table |

	page := GoogleChromeTestResource current page.

	tables := page rootNode findAllTags: 'table'.

	table := tables first tableData.
	self assert: table size equals: 3.
	self assert: (table at: 1) equals: #('Col 1' 'Col 2').
	self assert: (table at: 2) equals: #('Cell 11' 'Cell 21').
	self assert: (table at: 3) equals: #('Cell 12' 'Cell 22').

	table := (tables at: 2) tableData.
	self assert: table size equals: 3.
	self assert: (table at: 1) size equals: 3.
	self assert: (table at: 2) size equals: 2.
	self assert: (table at: 3) size equals: 3
]
