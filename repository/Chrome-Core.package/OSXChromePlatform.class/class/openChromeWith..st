utilities
openChromeWith: arguments
 	
	| executableLocation |
	executableLocation := self defaultExecutableLocation copyReplaceAll: ' ' with: '\ '.
	#OSXProcess asClass createProcess: executableLocation,' ', arguments, ' &'