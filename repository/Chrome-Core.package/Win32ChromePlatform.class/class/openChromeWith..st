utilities
openChromeWith: arguments
 	
	| executableLocation cmd |
	executableLocation := self defaultExecutableLocation.
	cmd := arguments ifEmpty: [ executableLocation ]
						 ifNotEmpty: [ executableLocation, ' ', arguments ].
	#WinProcess asClass createProcess: cmd