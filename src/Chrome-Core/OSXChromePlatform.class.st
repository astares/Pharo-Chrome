"
Chrome on OSX
"
Class {
	#name : #OSXChromePlatform,
	#superclass : #ChromePlatform,
	#category : 'Chrome-Core-Utilities'
}

{ #category : #defaults }
OSXChromePlatform class >> defaultExecutableLocation [

	^'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'
]

{ #category : #'private - testing' }
OSXChromePlatform class >> isActive [
	"Return true if the platform is active"

	^ Smalltalk os isMacOS
]

{ #category : #utilities }
OSXChromePlatform class >> openChromeWith: arguments [

	| executableLocation cmd |
	executableLocation := '"',self defaultExecutableLocation,'"'.
	cmd := arguments ifEmpty: [ executableLocation ]
						 ifNotEmpty: [ executableLocation,
										"The argument string always includes a leading space"
										(self stringFromArguments: arguments) ].

	LibC system:  cmd
]
