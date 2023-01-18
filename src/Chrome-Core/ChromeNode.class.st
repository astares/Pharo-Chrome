"
A node in Chrome
"
Class {
	#name : #ChromeNode,
	#superclass : #Object,
	#instVars : [
		'dictionary',
		'parent'
	],
	#category : 'Chrome-Core-Nodes'
}

{ #category : #'instance creation' }
ChromeNode class >> fromDictionary: aJsonDictionary parent: parentNode [

	^(self new)
		initialize: aJsonDictionary parent: parentNode;
		yourself
]

{ #category : #enumerating }
ChromeNode >> allChildrenDo: aBlock [
	"Apply the argument on all descendants of the receiver"

	self children do: [ :child |
		aBlock value: child.
		child allChildrenDo: aBlock]
]

{ #category : #enumerating }
ChromeNode >> allSelect: aBlock [
	"Like Collection>>select:, answer an array of nodes for which aBlock returns true.
	Note that this method assumes all child nodes have been retrieved from Chrome."

	^Array streamContents: [ :stream |
		(aBlock value: self) ifTrue: [ stream nextPut: self ].
		self allChildrenDo: [ :each | (aBlock value: each) ifTrue:
			[ stream nextPut: each ] ].
		]
]

{ #category : #accessing }
ChromeNode >> atNodeId: anInteger [
	"Answer the requested node"

	^self detect: [ :each | each nodeId = anInteger ]
]

{ #category : #accessing }
ChromeNode >> attributeAt: attributeName [

	^self attributes at: attributeName
]

{ #category : #accessing }
ChromeNode >> attributeAt: attributeName ifAbsent: absentBlock [

	^self attributes at: attributeName ifAbsent: [ absentBlock value ]
]

{ #category : #accessing }
ChromeNode >> attributes [
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	| attributeArray attributes |
	attributes := Dictionary new.
	attributeArray := dictionary at: 'attributes' ifAbsent: [^attributes].
	1 to: attributeArray size by: 2 do: [ :i |
		attributes at: (attributeArray at: i) put: (attributeArray at: i+1) ].
	^attributes
]

{ #category : #accessing }
ChromeNode >> baseURL [
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	^dictionary at: 'baseURL' ifAbsent: [nil]
]

{ #category : #accessing }
ChromeNode >> childNodeCount [
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	^dictionary at: 'childNodeCount' ifAbsent: [0]
]

{ #category : #accessing }
ChromeNode >> childNodeCount: aNumber [

	^dictionary at: 'childNodeCount' put: aNumber
]

{ #category : #'finding tags' }
ChromeNode >> childTagsDo: aBlock [
	"Apply the arguments on the direct tag elements of the receiver"

	self childrenDo: [ :anElement |
		anElement ifTag: [aBlock value: anElement] ]
]

{ #category : #accessing }
ChromeNode >> children [
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	^(dictionary at: 'children' ifAbsent: [#()]) collect:
		[ :each | self class fromDictionary: each parent: self ]
]

{ #category : #accessing }
ChromeNode >> children: anArray [
	"Replace the current children with the supplied Array of Dictionaries"

	^dictionary at: 'children' put: anArray
]

{ #category : #enumerating }
ChromeNode >> childrenDo: aBlock [
	"Apply the argument on the direct childent of the receiver"

	self children do: aBlock
]

{ #category : #accessing }
ChromeNode >> contentDocument [
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	^dictionary at: 'contentDocument' ifAbsent: [nil]
]

{ #category : #accessing }
ChromeNode >> contents [

	^self nodeValue
]

{ #category : #'finding strings' }
ChromeNode >> createFindStringBlock: anObject [
	(anObject isKindOf: Boolean) ifTrue: [^ [:aTag | anObject]].
	anObject isString ifTrue: [^ [:aString | aString contents = anObject]].
	anObject isMatcher ifTrue: [^ [:aString | anObject search: aString contents]].
	anObject isCollection ifTrue: [^ [:aString | anObject includes: aString contents]].
	^ anObject
]

{ #category : #'finding tags' }
ChromeNode >> createFindTagBlock: anObject [
	(anObject isKindOf: Boolean) ifTrue: [^ [:aTag | anObject]].
	anObject isString ifTrue: [^ [:aTag | aTag name = anObject]].
	anObject isCollection ifTrue: [^ [:aTag | anObject includes: aTag name]].
	^ anObject
]

{ #category : #enumerating }
ChromeNode >> detect: aBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.
	Answer the first element for which aBlock evaluates to true."

	^ self detect: aBlock ifNone: [NotFound signalFor: aBlock]
]

{ #category : #enumerating }
ChromeNode >> detect: aBlock ifFound: foundBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.
	If some element evaluates aBlock to true, then cull this element into
	foundBlock.
	If no element matches the criteria then do nothing.
	Always returns self to avoid misuse and a potential isNil check on the sender."

	^self
		detect: aBlock
		ifFound: foundBlock
		ifNone: [
			"Do nothing on purpose"
			 ]
]

{ #category : #enumerating }
ChromeNode >> detect: aBlock ifFound: foundBlock ifNone: execptionBlock [
	"Detect the node matching aBlock.  Any child nodes are also searched."

	(aBlock value: self) ifTrue: [ ^foundBlock cull: self ].
	self allChildrenDo: [ :each |
		(aBlock value: each) ifTrue: [ ^foundBlock cull: each ] ].
	^execptionBlock value
]

{ #category : #enumerating }
ChromeNode >> detect: aBlock ifNone: exceptionBlock [
	"Evaluate aBlock with each of the receiver and child nodes as the argument.
	Answer the first node for which aBlock evaluates to true. If none
	evaluate to true, then evaluate the argument, exceptionBlock."

	^ self detect: aBlock ifFound: [ :element | element ] ifNone: exceptionBlock
]

{ #category : #private }
ChromeNode >> dictionary [

	^dictionary
]

{ #category : #accessing }
ChromeNode >> distributedNodes [
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	^dictionary at: 'distributedNodes' ifAbsent: [nil]
]

{ #category : #accessing }
ChromeNode >> documentURL [
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	^dictionary at: 'documentURL' ifAbsent: [nil]
]

{ #category : #accessing }
ChromeNode >> extractTables [
	"Answer a Dictionary of the tables in the receiver"

	| tableNodes tables tableId |

	tables := Dictionary new.
	tableNodes := self findAllTags: 'table'.
	tableNodes withIndexDo: [ :node :index |
		tableId := node attributeAt: 'id' ifAbsent: 'table', index asString.
		tables at: tableId put: (node tableData) ].
	^tables
]

{ #category : #'finding strings' }
ChromeNode >> findAllStrings: anObject [
	"Returns all the strings equal to the argument. Note that the argument can be a string, a Boolean, a regex or a collection of strings to match several elements"

	| block |
	block := self createFindStringBlock: anObject.
	^ Array streamContents: [ :aStream |
			self findAllStrings: block stream: aStream ]
]

{ #category : #'finding strings' }
ChromeNode >> findAllStrings: anObject stream: aStream [
	| findBlock |
	findBlock := self createFindStringBlock: anObject.
	self isString
			ifTrue: [(findBlock value: self) ifTrue: [aStream nextPut: self]]
			ifFalse:[ self childrenDo: [:ch | ch findAllStrings: anObject stream: aStream]]
]

{ #category : #'finding tags' }
ChromeNode >> findAllTags: anObject [
	| findBlock |
	findBlock := self createFindTagBlock: anObject.
	^ Array streamContents: [ :aStream |
		self findAllTags: findBlock stream: aStream ]
]

{ #category : #'finding tags' }
ChromeNode >> findAllTags: anObject stream: aStream [
	| findBlock |
	findBlock := self createFindTagBlock: anObject.
	self childTagsDo: [ :aTag |
			(findBlock value: aTag) ifTrue: [aStream nextPut: aTag].
			aTag findAllTags: findBlock stream: aStream ]
]

{ #category : #accessing }
ChromeNode >> frameId [
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	^dictionary at: 'frameId' ifAbsent: [nil]
]

{ #category : #inspecting }
ChromeNode >> gtInspectorChildrenHierarchyIn: composite [
	<gtInspectorPresentationOrder: 2>

	^ composite tree
		title: 'Chidren Hierarchy';
		display: [ :root | self ];
		children: [ :each | each children ];
		format: [:each | each nodeName ]
]

{ #category : #inspecting }
ChromeNode >> gtInspectorChildrenIn: composite [
	<gtInspectorPresentationOrder: 2>

	^ (composite fastTable)
		title: 'Children';
		display: [ self children ];
		column: 'Name'
			evaluated: [:each | GTObjectPrinter asTruncatedTextFrom: each nodeName ];
		column: 'Contents'
			evaluated: [:each | GTObjectPrinter asTruncatedTextFrom: each contents ];
		send: [ :selection | selection ]
]

{ #category : #inspecting }
ChromeNode >> gtInspectorNodeIn: composite [
	<gtInspectorPresentationOrder: 1>

	^ (composite fastTable)
		title: 'Node';
		display: [ self dictionary associations ];
		column: 'Key'
			evaluated: [:each | GTObjectPrinter asTruncatedTextFrom: each key ];
		column: 'Value'
			evaluated: [:each | GTObjectPrinter asTruncatedTextFrom: each value ];
		send: [ :selection | selection ]
]

{ #category : #testing }
ChromeNode >> ifTag: aBlock [
	"Evaluate aBlock if the receiver is a tag"

	^self isTag ifTrue: [ aBlock value ]
]

{ #category : #accessing }
ChromeNode >> importedDocument [
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	^dictionary at: 'importedDocument' ifAbsent: [nil]
]

{ #category : #initialize }
ChromeNode >> initialize: aJsonDictionary parent: aParentNode [

	dictionary := aJsonDictionary.
	parent := aParentNode
]

{ #category : #accessing }
ChromeNode >> internalSubset [
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	^dictionary at: 'internalSubset' ifAbsent: [nil]
]

{ #category : #testing }
ChromeNode >> isString [

	^self nodeType = 3
]

{ #category : #testing }
ChromeNode >> isTable [
	"Answer a boolean indicating whether the receiver is a table"

	^self isTag and: [ self nodeName asLowercase = 'table' ]
]

{ #category : #testing }
ChromeNode >> isTag [
	"Answer a boolean indicating whether the receiver is a tag"

	^self nodeType = 1
]

{ #category : #accessing }
ChromeNode >> localName [
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	^dictionary at: 'localName'
]

{ #category : #accessing }
ChromeNode >> name [
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	^dictionary at: 'localName'
]

{ #category : #accessing }
ChromeNode >> nodeId [
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	^dictionary at: 'nodeId'
]

{ #category : #accessing }
ChromeNode >> nodeName [
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	^dictionary at: 'nodeName'
]

{ #category : #accessing }
ChromeNode >> nodeType [
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	^dictionary at: 'nodeType'
]

{ #category : #accessing }
ChromeNode >> nodeValue [
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	^dictionary at: 'nodeValue'
]

{ #category : #accessing }
ChromeNode >> parent [
	^ parent
]

{ #category : #accessing }
ChromeNode >> parent: anObject [
	parent := anObject
]

{ #category : #printing }
ChromeNode >> printOn: aStream [

	super printOn: aStream.
	aStream << '('.
	self nodeId printOn: aStream.
	aStream
		<< ' ';
		<< self nodeName;
		<< ')'
]

{ #category : #accessing }
ChromeNode >> pseudoElements [
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	^dictionary at: 'pseudoElements' ifAbsent: [nil]
]

{ #category : #accessing }
ChromeNode >> pseudoType [
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	^dictionary at: 'pseudoType' ifAbsent: [nil]
]

{ #category : #accessing }
ChromeNode >> publicId [
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	^dictionary at: 'publicId' ifAbsent: [nil]
]

{ #category : #enumerating }
ChromeNode >> select: aBlock [
	"Like Collection>>select:, answer a collection of nodes for which aBlock returns true.
	Note that this method assumes all child nodes have been retrieved from Chrome."

	| newCollection |

	newCollection := OrderedCollection new.
	(aBlock value: self) ifTrue: [ newCollection add: self ].
	self childrenDo: [ :each | (aBlock value: each) ifTrue:
			[ newCollection add: each ] ].
	^newCollection
]

{ #category : #accessing }
ChromeNode >> shadowRootType [
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	^dictionary at: 'shadowRootType' ifAbsent: [nil]
]

{ #category : #accessing }
ChromeNode >> shadowRoots [
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	^dictionary at: 'shadowRoots' ifAbsent: [nil]
]

{ #category : #accessing }
ChromeNode >> systemId [
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	^dictionary at: 'systemId' ifAbsent: [nil]
]

{ #category : #accessing }
ChromeNode >> tableData [
	"Extract the table data from the receiver (table).
	This method is simplistic and assumes:
	- No nested tables
	- Cell contents are always single strings"

	| rows cells |

	self assert: self isTable description: '#tableData may only be sent to <table> nodes'.

	^Array streamContents: [ :stream |
		rows := self findAllTags: 'tr'.
		rows do: [ :row |
			stream nextPut: (Array streamContents: [ :rowStream |
				cells := row findAllTags: #('td' 'th').
				cells do: [ :cell |
					rowStream nextPut: (cell
						detect: [ :child | child isString ]
						ifNone: ['String not found']) contents ] ]) ] ]
]

{ #category : #accessing }
ChromeNode >> templateContent [
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	^dictionary at: 'templateContent' ifAbsent: [nil]
]

{ #category : #accessing }
ChromeNode >> value [
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	^dictionary at: 'value' ifAbsent: [nil]
]

{ #category : #accessing }
ChromeNode >> xmlVersion [
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	^dictionary at: 'xmlVersion' ifAbsent: [nil]
]
