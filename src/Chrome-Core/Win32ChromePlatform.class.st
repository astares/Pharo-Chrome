"
Chrome on Windows
"
Class {
	#name : #Win32ChromePlatform,
	#superclass : #ChromePlatform,
	#category : 'Chrome-Core-Utilities'
}

{ #category : #defaults }
Win32ChromePlatform class >> defaultExecutableLocation [

	^ (((self class environment at: #WinRegistryKey)
			 localMachine
		    queryValue: 'Path'
		    fromSubkey:
		    'SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe')
		   allButLast: 1) , '\chrome.exe'
]

{ #category : #'private - testing' }
Win32ChromePlatform class >> isActive [
	"Return true if the platform is active"

	^Smalltalk os isWindows
]

{ #category : #utilities }
Win32ChromePlatform class >> openChromeWith: arguments [

	| executableLocation cmd |
	executableLocation := '"',self defaultExecutableLocation,'"'.
	cmd := arguments ifEmpty: [ executableLocation ]
						 ifNotEmpty: [ executableLocation,' ',(self stringFromArguments: arguments) ].

	(self class environment at: #WinProcess) createProcess:  cmd
]
