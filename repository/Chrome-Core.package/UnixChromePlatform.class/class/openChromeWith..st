utilities
openChromeWith: arguments
 	
	| executableLocation argArray process |
	executableLocation := self defaultExecutableLocation copyReplaceAll: ' ' with: '\ '.
	argArray := Array streamContents: [ :stream |
		(' ' split: arguments) do: [ :each |
			each ifNotEmpty: [stream nextPut: each] ] ].
	process := AKGOSProcess command: executableLocation arguments: argArray.
	process run.
	^process