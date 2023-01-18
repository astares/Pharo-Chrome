"
Chrome on Unix flavours
"
Class {
	#name : #UnixChromePlatform,
	#superclass : #ChromePlatform,
	#category : 'Chrome-Core-Utilities'
}

{ #category : #defaults }
UnixChromePlatform class >> defaultExecutableLocation [

	^ self defaultExecutableLocations detect: [ :arg1 |
		  arg1 asFileReference exists ]
]

{ #category : #defaults }
UnixChromePlatform class >> defaultExecutableLocations [
	"Returns the default executable locations where one can find chrome or chromium"

	^ #( '/opt/google/chrome/chrome'
		  '/usr/bin/chromium-browser'
	     '/usr/local/share/chromium/chrome'
	     '/usr/bin/chromium'
		  '/snap/bin/chromium'
	 )
]

{ #category : #'private - testing' }
UnixChromePlatform class >> isActive [
	"Return true if the platform is active"

	^Smalltalk os isUnix
]

{ #category : #utilities }
UnixChromePlatform class >> openChromeWith: arguments [

	| executableLocation cmd |
	executableLocation := '"',self defaultExecutableLocation,'"'.
	cmd := arguments ifEmpty: [ executableLocation ]
						 ifNotEmpty: [ executableLocation,
										"The argument string always includes a leading space"
										(self stringFromArguments: arguments) ].

	LibC system:  cmd
]
