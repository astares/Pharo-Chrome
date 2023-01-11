utilities
openChromeWith: arguments

	| executableLocation cmd |
	executableLocation := '"',self defaultExecutableLocation,'"'.
	cmd := arguments ifEmpty: [ executableLocation ]
						 ifNotEmpty: [ executableLocation,' ',(self stringFromArguments: arguments) ].

	(self class environment at: #WinProcess) createProcess:  cmd