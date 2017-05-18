initialization
initialize
	| debugOn |
	super initialize.
	debugOn := true.
	debugPort := GoogleChromeSettings debugPort.
	host := 'localhost'