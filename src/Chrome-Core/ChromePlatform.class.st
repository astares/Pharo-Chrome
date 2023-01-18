"
A chrome platform
"
Class {
	#name : #ChromePlatform,
	#superclass : #Object,
	#category : 'Chrome-Core-Utilities'
}

{ #category : #accessing }
ChromePlatform class >> current [

	^self subclasses
		detect: [:each | each isActive ]
		ifNone: [ self error: 'No support for platform' ]
]

{ #category : #defaults }
ChromePlatform class >> defaultDebugPort [

	^9222
]

{ #category : #defaults }
ChromePlatform class >> defaultExecutableLocation [
	"Return the default location of the chrome executable as string"

	^self subclassResponsibility
]

{ #category : #'private - testing' }
ChromePlatform class >> isActive [

	^self subclassResponsibility
]

{ #category : #utilities }
ChromePlatform class >> openChrome [
	<script>
	self current openChromeWith: ''
]

{ #category : #utilities }
ChromePlatform class >> openInDebugMode [
	<script>
	self current openChromeWith: #('--remote-debugging-port=9222')
]

{ #category : #private }
ChromePlatform class >> stringFromArguments: arguments [
	"Answer a string representation of the supplied argument array"

	^String streamContents: [ :stream |
		arguments do: [ :argument |
			"Enclose arguments that aren't options in quotes"
			argument first = $- ifFalse:
				[
				stream
					<< ' "';
					<< argument;
					<< '"'
				]
			ifTrue:
				[
				stream
					<< ' ';
					<< argument
				].
			].
		]
]
