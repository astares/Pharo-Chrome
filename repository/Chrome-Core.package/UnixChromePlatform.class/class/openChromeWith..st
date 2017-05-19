utilities
openChromeWith: arguments
 	
	| executableLocation |
	executableLocation := self defaultExecutableLocation copyReplaceAll: ' ' with: '\ '.
	#UNIXSystem asClass system: executableLocation,' ', arguments, ' &'