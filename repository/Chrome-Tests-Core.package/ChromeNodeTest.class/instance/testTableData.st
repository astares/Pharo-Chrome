tests
testTableData

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
	self assert: (table at: 3) size equals: 3.