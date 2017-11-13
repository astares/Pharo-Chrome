tests
testExtractTables
	"Check that the expected number of tables with the correct labels is returned.
	The contents of the tables are checked in the node tests"

	| page |

	page := GoogleChromeTestResource current page.
	self assert: page extractTables keys sorted equals: #('First Table' 'table2').