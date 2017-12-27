settings
addArgumentsToStream: stream
	"Add the command line arguments for the current settings"

	userDataDir ifNotNil: 
		[ stream nextPut: '--user-data-dir=', userDataDir fullName ].
	self headless ifTrue: 
		[ stream nextPut: '--headless' ].
	self disableGPU ifTrue:
		[ stream nextPut: '--disable-gpu' ].
	self isInDebugMode ifTrue: 
		[ stream nextPut: '--remote-debugging-port=', self debugPort asString ].
