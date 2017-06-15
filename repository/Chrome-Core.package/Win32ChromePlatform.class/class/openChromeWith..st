utilities
openChromeWith: arguments
 	
	| executableLocation cmd |
	executableLocation := self defaultExecutableLocation.
	cmd := arguments ifEmpty: [ executableLocation ]
						 ifNotEmpty: [ executableLocation, 
										"The argument string always includes a leading space"
										(self stringFromArguments: arguments) ].
	#WinProcess asClass createProcess: cmd