utilities
openChromeWith: arguments
 	
	| executableLocation process |
	executableLocation := self defaultExecutableLocation copyReplaceAll: ' ' with: '\ '.
	process := AKGOSProcess command: executableLocation arguments: arguments.
	process run.
	^process