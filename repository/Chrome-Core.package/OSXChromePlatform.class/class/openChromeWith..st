utilities
openChromeWith: arguments
 	
	| executableLocation |
	executableLocation := self defaultExecutableLocation copyReplaceAll: ' ' with: '\ '.
	#OSXProcess asClass createProcess: 
			executableLocation,
			"the argument string always includes a leading space"
			(self stringFromArguments: arguments),
			' &'