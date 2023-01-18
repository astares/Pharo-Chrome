"
A chrome tab page

Pharo communicates with a Chrome Tab using a web socket (webSocket) and asynchronous message sends.  A messageId is used to link requests and responses.

Since the browser can send event messages at any time, and also doesn't seem to like messages backing up, a separate message read process is forked.  Messages are read from the browser and passed on to all registered message processors (ChromeMessageProcessor subclasses).  Semaphores are used by ChromeMessageBrowser to signal the calling process when the requested state has been reached, e.g. a response to a request has been received, the page has ""completed"" loading, etc.

See GoogleChrome class>>exampleNavigation for an example of interacting with a ChromeTabPage.

Instance Variables:

	id:	<String> The page id assigned by the browser
	webSocketDebuggerUrl: <String> The URL assigned by the browser
	webSocket: <ZnWebSocket> the connection to the browser page
	messageId: <Integer> The last request message id used
	messageListener: <Process> The message listener.  Just for easy reference when debugging.
	messageProcessors: <OrderedCollection> The currently registered ChromeMessageProcessors
	messageQueue: <OrderedCollection> All messages received from the browser.  For debugging only and should eventually be removed.
	rootNode: The root ChromeNode of the current page
	pageLoadDelay: The default number of milliseconds to wait for the page to become idle after nagivation.
"
Class {
	#name : #ChromeTabPage,
	#superclass : #Object,
	#instVars : [
		'id',
		'type',
		'title',
		'description',
		'url',
		'webSocketDebuggerUrl',
		'devtoolsFrontendUrl',
		'webSocket',
		'socketState',
		'messageId',
		'messageListener',
		'messageProcessors',
		'messageProcessorMutex',
		'messageQueue',
		'rootNode',
		'pageLoadDelay'
	],
	#category : 'Chrome-Core-Model'
}

{ #category : #'instance creation' }
ChromeTabPage class >> fromDictionary: aDictionary [

	^(self new)
		id: (aDictionary at: #id);
		type: (aDictionary at: #type);
		title: (aDictionary at: #title);
		description: (aDictionary at: #description);
		url: (aDictionary at: #url);
		webSocketDebuggerUrl: (aDictionary at: #webSocketDebuggerUrl);
		devtoolsFrontendUrl: (aDictionary at: #devtoolsFrontendUrl);
		yourself
]

{ #category : #private }
ChromeTabPage >> addMessageProcessor: aMessageProcessor [

	^messageProcessorMutex critical:
		[ messageProcessors add: aMessageProcessor ]
]

{ #category : #'operations - page' }
ChromeTabPage >> captureScreenshot [

	| base64 json layout clip |
	layout := self getLayoutMetrics.
	clip := {
		'x' -> 0.
		'y' -> 0.
		'width' -> ((layout at: 'contentSize') at: 'width').
		'height' -> ((layout at: 'contentSize') at: 'height').
		'scale' -> 1.0. } asDictionary.
	json := self sendMessage: {
        'method' -> 'Page.captureScreenshot'.
        'params' -> { 'clip' -> clip } asDictionary.
      } asDictionary.
	base64 := (json at: 'result') at: 'data'.

	^Form fromBinaryStream: base64 base64Decoded readStream
]

{ #category : #private }
ChromeTabPage >> checkResponse: responseDictionary [

	(responseDictionary includesKey: 'error') ifTrue:
		[ self halt: 'looks like bad response' ].
	^true
]

{ #category : #'initialize-release' }
ChromeTabPage >> close [

	socketState := #closed.
	self webSocket close.
	webSocket := nil
]

{ #category : #accessing }
ChromeTabPage >> description [
	^ description
]

{ #category : #'private - accessing' }
ChromeTabPage >> description: anObject [
	description := anObject
]

{ #category : #'private - accessing' }
ChromeTabPage >> devtoolsFrontendUrl [
	^ devtoolsFrontendUrl
]

{ #category : #'private - accessing' }
ChromeTabPage >> devtoolsFrontendUrl: anObject [
	devtoolsFrontendUrl := anObject
]

{ #category : #'operations - dom' }
ChromeTabPage >> enableDOM [

	^self sendMessage: ({
        'method' -> 'DOM.enable'
      } asDictionary)
]

{ #category : #'operations - debugger' }
ChromeTabPage >> enableDebugger [

	^self sendMessage: {
        'method' -> 'Debugger.enable'
      } asDictionary
]

{ #category : #'operations - network' }
ChromeTabPage >> enableNetwork [

	^self sendMessage: ({
        'method' -> 'Network.enable'
      } asDictionary)
]

{ #category : #'operations - page' }
ChromeTabPage >> enablePage [

	^self sendMessage: {
        'method' -> 'Page.enable'
      } asDictionary
]

{ #category : #'operations - runtime' }
ChromeTabPage >> evaluate: aString [

	^self sendMessage: {
        'method' -> 'Runtime.evaluate'.
        'params' -> {'expression' -> aString} asDictionary
      } asDictionary
]

{ #category : #accessing }
ChromeTabPage >> extractTables [
	"Answer a Dictionary of the tables in the receiver"

	^self rootNode extractTables
]

{ #category : #'operations - page' }
ChromeTabPage >> get: anURL [
	"Navigate to the supplied URL, retrieve the DOM and answer the root node"

	self
		enableDOM;
		enablePage;
		navigateTo: anURL;
		getDocument;
		getMissingChildren.
	^self rootNode
]

{ #category : #'operations - dom' }
ChromeTabPage >> getDocument [

	| result |
	result := self sendMessage: ({
        'method' -> 'DOM.getDocument'
      } asDictionary).
	self checkResponse: result.
	rootNode := ChromeNode fromDictionary: ((result at: 'result') at: 'root') parent: nil.
	^rootNode
]

{ #category : #'operations - page' }
ChromeTabPage >> getLayoutMetrics [

	| result |
	result := self sendMessage: {
        'method' -> 'Page.getLayoutMetrics'.
        'params' ->  { }
      } asDictionary.
	^result at: 'result'
]

{ #category : #'operations - dom' }
ChromeTabPage >> getMissingChildren [

	| childless |
	childless := rootNode allSelect: [ :each | each childNodeCount > each children size ].
	[ childless notEmpty ] whileTrue:
		[ childless do: [ :each | self requestChildNodesAt: each depth: 100 ].
		childless := rootNode allSelect: [ :each | each childNodeCount > each children size ] ]
]

{ #category : #'operations - dom' }
ChromeTabPage >> getOuterHTML: nodeId [

	^self sendMessage: {
        'method' -> 'DOM.getOuterHTML'.
        'params' -> {'nodeId' -> nodeId} asDictionary.
      } asDictionary
]

{ #category : #accessing }
ChromeTabPage >> html [

	| ston |

	ston := STON fromString: (self evaluate: 'document.documentElement.outerHTML').
	^((ston at: 'result') at: 'result') at: 'value'
]

{ #category : #'private - accessing' }
ChromeTabPage >> id [
	^ id
]

{ #category : #'private - accessing' }
ChromeTabPage >> id: anObject [
	id := anObject
]

{ #category : #initialize }
ChromeTabPage >> initialize [

	super initialize.
	messageId := 0.
	messageProcessors := OrderedCollection new.
	messageProcessorMutex := Mutex new.
	messageQueue := OrderedCollection new.
	pageLoadDelay := 2000.
	socketState := #closed.
	webSocket := nil
]

{ #category : #testing }
ChromeTabPage >> isClosed [
	"Answer a boolean indicating whether the connection to the browser is closed"

	^socketState = #closed
]

{ #category : #testing }
ChromeTabPage >> isOpen [
	"Answer a boolean indicating whether the connection to the browser is open"

	^socketState = #open
]

{ #category : #testing }
ChromeTabPage >> isPage [

	^self type = 'page'
]

{ #category : #'operations - page' }
ChromeTabPage >> navigateTo: anURL [

	| result processor |

	self assert: anURL isNotNil.
	"Add the frame loading processor so it can collect messages until the frameId is known"
	processor := ChromeFrameLoadingProcessor frameId: nil.
	processor pageLoadDelay: pageLoadDelay.
	self addMessageProcessor: processor.
	result := self sendMessage: {
        'method' -> 'Page.navigate'.
        'params' -> { 'url' -> anURL } asDictionary.
		} asDictionary.
	"Update the frame loading processor with the frame id.  This will also process any saved messages."
	processor frameId: ((result at: 'result') at: 'frameId').
	processor wait.
	"self removeMessageProcessor: processor."
	^result
]

{ #category : #'private - accessing' }
ChromeTabPage >> nextMessageId [

	^messageId := messageId + 1
]

{ #category : #accessing }
ChromeTabPage >> pageLoadDelay [
	^ pageLoadDelay
]

{ #category : #accessing }
ChromeTabPage >> pageLoadDelay: anObject [
	pageLoadDelay := anObject
]

{ #category : #printing }
ChromeTabPage >> printOn: aStream [

	aStream nextPutAll: self title asString
]

{ #category : #private }
ChromeTabPage >> processReceivedMessage: aMessageString [
	"Process the supplied message by passing it on to each of the current processors"
	| ston |

	ston := STON fromString: aMessageString.
	messageProcessorMutex critical:
		[ messageProcessors do: [ :each | each processMessage: ston ] ]
]

{ #category : #private }
ChromeTabPage >> removeMessageProcessor: aMessageProcessor [

	^messageProcessorMutex critical:
		[ messageProcessors remove: aMessageProcessor ]
]

{ #category : #'operations - dom' }
ChromeTabPage >> requestChildNodesAt: rootNode depth: depth [

	| result processor |

	processor := ChromeSetChildNodeProcessor rootNode: rootNode.
	self addMessageProcessor: processor.
	result := self sendMessage: {
        'method' -> 'DOM.requestChildNodes'.
        'params' -> {'nodeId' -> rootNode nodeId. 'depth' -> depth} asDictionary
      } asDictionary.
	self checkResponse: result.
	processor wait.
	self removeMessageProcessor: processor.
	^result
]

{ #category : #accessing }
ChromeTabPage >> rootNode [
	"Answer the root ChromeNode of the receiver"
	^rootNode
]

{ #category : #private }
ChromeTabPage >> sendMessage: aDictionary [
	"Send the supplied message to the browser, wait for the response and raise an exception on failure."

	^self sendMessage: aDictionary wait: true
]

{ #category : #private }
ChromeTabPage >> sendMessage: aDictionary wait: waitBoolean [
	"Send the supplied message to the browser, if requested, wait for the response and raise an exception on failure."

	| result processor mid |

	result := nil.
	"Ensure that a message id is included"
	mid := aDictionary at: 'id' ifAbsentPut: [self nextMessageId].
	"If waiting, set up the message processor to signal on completion"
	waitBoolean ifTrue: [
		processor := ChromeStatusMessageProcessor forMessageId: mid.
		self addMessageProcessor: processor ].
	"Send the message"
	self sendMessageString: (STON toJsonString: aDictionary).
	"If requested, wait for operation completion"
	waitBoolean ifTrue: [
		processor wait.
		self checkResponse: processor result.
		self removeMessageProcessor: processor.
		result := processor result ].
	^result
]

{ #category : #private }
ChromeTabPage >> sendMessageString: aMessageString [

	^self webSocket sendMessage: aMessageString
]

{ #category : #private }
ChromeTabPage >> startMessageListener [
	"Start the page's message receiving and processing process."
	| messageString |

	messageListener := [ [ self isOpen ] whileTrue:
		[ [ [ messageString := self webSocket readMessage.
			messageQueue add: messageString.
			self processReceivedMessage: messageString]
			on: ConnectionTimedOut
			do: [ :ex |
					ex retry ] ]
				on: ConnectionClosed
				do: [ :ex |
					socketState := #closed.
					webSocket := nil ] ].
	] forkNamed: 'ChromeTabPage ', id printString
]

{ #category : #accessing }
ChromeTabPage >> title [
	^ title
]

{ #category : #'private - accessing' }
ChromeTabPage >> title: anObject [
	title := anObject
]

{ #category : #accessing }
ChromeTabPage >> type [
	^ type
]

{ #category : #'private - accessing' }
ChromeTabPage >> type: anObject [
	type := anObject
]

{ #category : #operating }
ChromeTabPage >> updateTitle [

	| result |

	result := self evaluate: 'document.title'.
	^self title: (((result at: 'result') at: 'result') at: 'value')
]

{ #category : #'private - accessing' }
ChromeTabPage >> url [
	^ url
]

{ #category : #'private - accessing' }
ChromeTabPage >> url: anObject [
	url := anObject
]

{ #category : #accessing }
ChromeTabPage >> webSocket [

	^webSocket ifNil:
		[ webSocket := ZnWebSocket to: self webSocketDebuggerUrl.
		socketState := #open.
		self startMessageListener.
		webSocket ]
]

{ #category : #'private - accessing' }
ChromeTabPage >> webSocketDebuggerUrl [
	^ webSocketDebuggerUrl
]

{ #category : #'private - accessing' }
ChromeTabPage >> webSocketDebuggerUrl: anObject [
	webSocketDebuggerUrl := anObject
]
