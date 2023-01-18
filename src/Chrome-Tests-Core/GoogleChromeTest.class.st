"
Unit test for google chrome
"
Class {
	#name : #GoogleChromeTest,
	#superclass : #TestCase,
	#category : 'Chrome-Tests-Core-Base'
}

{ #category : #resources }
GoogleChromeTest class >> resources [

	^{ GoogleChromeTestResource }
]

{ #category : #tests }
GoogleChromeTest >> testDebugOn [
	|instance|
	instance := GoogleChrome new.
	self assert: instance isInDebugMode
]

{ #category : #tests }
GoogleChromeTest >> testDebugOnOff [
	|instance|

	instance := GoogleChrome new.
	self assert: instance isInDebugMode.

	instance debugOn.
	self assert: instance isInDebugMode.

	instance debugOff.
	self deny: instance isInDebugMode
]

{ #category : #tests }
GoogleChromeTest >> testExtractTables [
	"Check that the expected number of tables with the correct labels is returned.
	The contents of the tables are checked in the node tests"

	| page |

	page := GoogleChromeTestResource current page.
	self assert: page extractTables keys sorted equals: #('First Table' 'table2')
]

{ #category : #tests }
GoogleChromeTest >> testPage1Document [
	"Check that Page1 has loaded correctly"

	| page rootNode h1 a |

	page := GoogleChromeTestResource current page.
	rootNode := page rootNode.
	h1 := rootNode findAllTags: 'h1'.
	self assert: h1 isNotEmpty description: 'Failed to find expected heading node'.
	self assert: h1 size equals: 1.
	h1 := h1 first.
	self assert: h1 children first contents equals: 'Title One'.
	a := rootNode findAllTags: 'a'.
	self assert: a isNotEmpty description: 'Failed to find expected anchour node'.
	self assert: a size equals: 1.
	a := a first.
	self assert: (a attributeAt: 'href') equals: 'http://pharo.org'
]

{ #category : #tests }
GoogleChromeTest >> testPage1Title [
	"Check that the expected title is returned"

	| page |

	page := GoogleChromeTestResource current page.
	self assert: page title equals: 'Pharo-Chrome Test Page'
]

{ #category : #tests }
GoogleChromeTest >> testRegularCreatedIsNotDebugging [

	self assert: GoogleChrome new isInDebugMode
]
