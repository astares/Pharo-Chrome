"
Google Chrome

Instance Variables

	userDataDir	<FileReference or nil> The directory used by Chrome to store user data.  It also can be used to force Chrome to start a new session.
"
Class {
	#name : #GoogleChrome,
	#superclass : #Object,
	#instVars : [
		'host',
		'settings',
		'webSocket',
		'chromeProcess'
	],
	#category : 'Chrome-Core-Base'
}

{ #category : #examples }
GoogleChrome class >> exampleEvalutionOfJavaScript [

	self openForRemoteWork
 		tabPages first evaluate: 'alert(''Hello'')'
]

{ #category : #examples }
GoogleChrome class >> exampleNavigation [

	<gtExample>
	| chrome page logger |

	logger := MemoryLogger new.
	logger start.
	chrome := self new
            debugOn;
				debugSession;
            open;
            yourself.
	page := chrome tabPages first.
	page enablePage.
	page enableDOM.
	page navigateTo: 'http://pharo.org'.
	page getDocument.
	page getMissingChildren.
	page updateTitle.
	logger stop.
	^{ chrome. page. logger. }
]

{ #category : #'instance creation' }
GoogleChrome class >> get: anURL [
	"Answer the ChromeNode of the requested page"

	^self new get: anURL
]

{ #category : #'instance creation' }
GoogleChrome class >> open [
	<script>

	^(self new)
		open;
		yourself
]

{ #category : #'instance creation' }
GoogleChrome class >> openForRemoteWork [
	<script>

	^(self new)
		openForRemoteDebugging;
		yourself
]

{ #category : #accessing }
GoogleChrome class >> tabPages [

	| remotes |
	remotes := STON fromString: (ZnEasy get: 'http://localhost:9222/json') contents.
	^(remotes select: [ :each | each includesKey: #webSocketDebuggerUrl])
		collect: [:each | ChromeTabPage fromDictionary: each ]
]

{ #category : #utilities }
GoogleChrome >> browseProtocolJSON [
	"Return the browser_protocol.json"

	| base64 url |
	url := 'https://chromium.googlesource.com/chromium/src/+/', self webkitVersionHash,
			 '/third_party/WebKit/Source/core/inspector/browser_protocol.json?format=TEXT'.
	base64 := (ZnEasy get: url) contents.
	(STON fromString: base64 base64Decoded) inspect
]

{ #category : #'private - accessing' }
GoogleChrome >> chromeProcess [
	"Answer the receivers browser process.
	This really should be private, but is here so that automated tests can wait for process exit"

	^chromeProcess
]

{ #category : #operating }
GoogleChrome >> closeAndExit [
	"Ask the browser to exit"

	chromeProcess ifNotNil: [ chromeProcess sigterm ]
]

{ #category : #operating }
GoogleChrome >> debugOff [
	self settings isInDebugMode: false
]

{ #category : #operating }
GoogleChrome >> debugOn [
	self settings isInDebugMode: true
]

{ #category : #actions }
GoogleChrome >> debugSession [
	"Set the Chrome user directory to our default to ensure that we are running our instance of Chrome.
	This is typically done if you are running chrome without the remote debugging port enabled, and don't want to close the browser"

	self settings debugSession
]

{ #category : #accessing }
GoogleChrome >> firstTab [
	"Answer the first tab of the receiver"

	^self tabPages first
]

{ #category : #operating }
GoogleChrome >> get: anURL [
	"Answer the ChromeNode of the requested page"
	| page rootNode |

	self open.
	page := self firstTab.
	rootNode := page get: anURL.
	self closeAndExit.
	^rootNode
]

{ #category : #accessing }
GoogleChrome >> headless [

	^self settings headless
]

{ #category : #accessing }
GoogleChrome >> headless: aBoolean [
	"Set whether to launch chrome in headless mode.
	If true, disable the GPU (see https://developers.google.com/web/updates/2017/04/headless-chrome)"

	self settings headless: aBoolean
]

{ #category : #initialization }
GoogleChrome >> initialize [

	super initialize.
	self settings: GoogleChromeSettings new.
	self debugOn.
	host := 'localhost'
]

{ #category : #accessing }
GoogleChrome >> isInDebugMode [

	^self settings isInDebugMode
]

{ #category : #utilities }
GoogleChrome >> jsProtocolJSON [
	"Return the js_protocol.json"

	| base64 url |
	url := 'https://chromium.googlesource.com/chromium/src/+/' , self webkitVersionHash ,
			 '/third_party/WebKit/Source/platform/v8_inspector/js_protocol.json?format=TEXT'.
	base64 := (ZnEasy get: url) contents.
	(STON fromString: base64 base64Decoded) inspect
]

{ #category : #running }
GoogleChrome >> open [
	"Open in regular mode - note that the remote control is not available in this case"
	self openURL: ''
]

{ #category : #running }
GoogleChrome >> openForRemoteDebugging [
	"Open in debug mode"

	self
		debugOn;
		open.
	2 seconds wait.
	^self
]

{ #category : #'private - operating' }
GoogleChrome >> openURL: anURL [
	"Open the requested URL.
	If there is an existing instance of Chrome that we can connect to, use that, if not, launch a new instance"
	| args retryCount version |

	[ self version ]
		on: ConnectionTimedOut
		do: [ :ex |
			args := Array streamContents: [ :stream |
				self settings addArgumentsToStream: stream.
				anURL ifNotEmpty:
					[ stream nextPut: anURL ] ].
			chromeProcess := ChromePlatform current openChromeWith: args.
			"It can take a while for the browser to actually start.
			Ping the browser until we get a successfull response."
			retryCount := 10.
			[ version := self version ]
				on: ConnectionTimedOut
				do: [ :ex1 |
					retryCount > 0 ifTrue:
						[ retryCount := retryCount - 1.
						1 second wait.
						ex1 retry. ]
					ifFalse:
						[ ex1 pass ]
					].
		]
]

{ #category : #accessing }
GoogleChrome >> settings [
	^ settings
]

{ #category : #accessing }
GoogleChrome >> settings: anObject [
	settings := anObject
]

{ #category : #accessing }
GoogleChrome >> tabPages [

	| tabs |
	tabs := self class tabPages.
	tabs ifEmpty: [ self error: 'Unable to find a debug tab page.  Please close the browser and start again' ].
	^tabs
]

{ #category : #accessing }
GoogleChrome >> userDataDir [
	^self settings userDataDir
]

{ #category : #accessing }
GoogleChrome >> userDataDir: anObject [
	"Set Chrome's user data directory to the supplied directory (which must already exist).
	nil = Chrome's default directory (current user's directory)"
	self settings userDataDir: anObject
]

{ #category : #accessing }
GoogleChrome >> version [
	"Return a dictionary with version information"

	^STON fromURL: 'http://localhost:9222/json/version'
]

{ #category : #'private - accessing' }
GoogleChrome >> webkitVersionHash [
	"Return the protocol.json description"

	| matcher webkitVersion |
	webkitVersion := self version at: 'WebKit-Version'.
	matcher := '[1-9.]*\s\(@([0-9a-z]*)\)' asRegex.
	(matcher matches: webkitVersion)
		ifFalse: [ self error: 'Does not match' ].
	^ (matcher subexpression: 2) first: 6
]
