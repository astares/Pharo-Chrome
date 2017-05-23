initialization
initialize
	 
	super initialize.
	self debugOn.
	debugPort := GoogleChromeSettings debugPort.
	host := 'localhost'