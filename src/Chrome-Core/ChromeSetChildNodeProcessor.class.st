"
Process setting of a child node
"
Class {
	#name : #ChromeSetChildNodeProcessor,
	#superclass : #ChromeMessageProcessor,
	#instVars : [
		'startedFrames',
		'loadedFrames',
		'rootNode',
		'result'
	],
	#category : 'Chrome-Core-Model'
}

{ #category : #'instance creation' }
ChromeSetChildNodeProcessor class >> rootNode: rootNode [

	^self new
		rootNode: rootNode;
		yourself
]

{ #category : #initialize }
ChromeSetChildNodeProcessor >> initialize [

	super initialize.
	startedFrames := Bag new.
	loadedFrames := Bag new
]

{ #category : #messages }
ChromeSetChildNodeProcessor >> processMessage: aMessageDictionary [

	| params parentId newNodes |

	aMessageDictionary at: 'method' ifPresent:
		[ :method |
			method = 'Page.frameStartedLoading' ifTrue:
				[ startedFrames add: ((aMessageDictionary at: 'params') at: 'frameId') ].
			method = 'Page.frameStoppedLoading' ifTrue:
				[ loadedFrames add: ((aMessageDictionary at: 'params') at: 'frameId') ].
			method = 'DOM.setChildNodes' ifTrue:
				[ params := aMessageDictionary at: 'params'.
				parentId := params at: 'parentId'.
				newNodes := params at: 'nodes'.
				parentId = rootNode nodeId ifTrue:
					[ rootNode children: (rootNode children, newNodes).
					rootNode childNodeCount: rootNode children size.
					semaphore signal ].
				].
			]
]

{ #category : #accessing }
ChromeSetChildNodeProcessor >> result [
	^ result
]

{ #category : #accessing }
ChromeSetChildNodeProcessor >> rootNode [
	^ rootNode
]

{ #category : #accessing }
ChromeSetChildNodeProcessor >> rootNode: anObject [
	rootNode := anObject
]
