"
General chrome settings
"
Class {
	#name : #GoogleChromeSettings,
	#superclass : #Object,
	#instVars : [
		'debugPort',
		'isInDebugMode',
		'userDataDir',
		'headless',
		'disableGPU'
	],
	#classVars : [
		'DebugPort',
		'ExecutableLocation'
	],
	#category : 'Chrome-Core-Settings'
}

{ #category : #settings }
GoogleChromeSettings class >> catalogSettingsOn: aBuilder [
	<systemsettings>
	(aBuilder group: #chrome)
		label: 'Chrome';
		parent: #tools;
		description: 'All Google Chrome settings';
		with: [
			(aBuilder setting: #debugPort)
						target: self;
						label: 'Debug Port';
						default: ChromePlatform current defaultDebugPort;
						description: 'Port to use for (remote) Chrome debugging'.
			(aBuilder setting: #executableLocation)
				target: self;
				label: 'Executable';
				type: #FilePathEncoder;
				description: 'Location of the Google Chrome executable'
		]
]

{ #category : #accessing }
GoogleChromeSettings class >> debugPort [
	"Return the debug port"

	^DebugPort ifNil: [ DebugPort := ChromePlatform current defaultDebugPort]
]

{ #category : #accessing }
GoogleChromeSettings class >> debugPort: aNumber [
	"Sets the debug port to the given port number"

	DebugPort := aNumber
]

{ #category : #accessing }
GoogleChromeSettings class >> executableLocation [

	^ExecutableLocation ifNil: [ ExecutableLocation := ChromePlatform current defaultExecutableLocation ]
]

{ #category : #accessing }
GoogleChromeSettings class >> executableLocation: aString [

	ExecutableLocation := aString
]

{ #category : #settings }
GoogleChromeSettings >> addArgumentsToStream: stream [
	"Add the command line arguments for the current settings"

	userDataDir ifNotNil:
		[ stream nextPut: '--user-data-dir=', userDataDir fullName ].
	self headless ifTrue:
		[ stream nextPut: '--headless' ].
	self disableGPU ifTrue:
		[ stream nextPut: '--disable-gpu' ].
	self isInDebugMode ifTrue:
		[ stream nextPut: '--remote-debugging-port=', self debugPort asString ]
]

{ #category : #actions }
GoogleChromeSettings >> debugOff [
	self isInDebugMode: false
]

{ #category : #actions }
GoogleChromeSettings >> debugOn [
	self isInDebugMode: true
]

{ #category : #accessing }
GoogleChromeSettings >> debugPort [
	^ debugPort
]

{ #category : #accessing }
GoogleChromeSettings >> debugPort: anObject [
	debugPort := anObject
]

{ #category : #actions }
GoogleChromeSettings >> debugSession [
	"Set the Chrome user directory to our default to ensure that we are running our instance of Chrome.
	This is typically done if you are running chrome without the remote debugging port enabled, and don't want to close the browser"

	| debugDataDir |

	debugDataDir := FileLocator temp / 'pharo' / 'GoogleChrome' / 'debugSession'.
	debugDataDir ensureCreateDirectory.
	self userDataDir: debugDataDir
]

{ #category : #accessing }
GoogleChromeSettings >> disableGPU [
	^ disableGPU
]

{ #category : #accessing }
GoogleChromeSettings >> disableGPU: anObject [
	disableGPU := anObject
]

{ #category : #accessing }
GoogleChromeSettings >> headless [
	^ headless
]

{ #category : #accessing }
GoogleChromeSettings >> headless: aBoolean [
	"Set whether to launch chrome in headless mode.
	If true, disable the GPU (see https://developers.google.com/web/updates/2017/04/headless-chrome)"

	headless := aBoolean.
	aBoolean ifTrue: [ self disableGPU: true ]
]

{ #category : #initialize }
GoogleChromeSettings >> initialize [

	super initialize.
	self
		debugOn;
		debugSession;
		debugPort: self class debugPort;
		disableGPU: false;
		headless: false
]

{ #category : #accessing }
GoogleChromeSettings >> isInDebugMode [
	^ isInDebugMode
]

{ #category : #accessing }
GoogleChromeSettings >> isInDebugMode: anObject [
	isInDebugMode := anObject
]

{ #category : #accessing }
GoogleChromeSettings >> userDataDir [
	^ userDataDir
]

{ #category : #accessing }
GoogleChromeSettings >> userDataDir: anObject [
	userDataDir := anObject
]
