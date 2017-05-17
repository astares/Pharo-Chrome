tests
testDebugOnOff
	|instance|
	
	instance := GoogleChrome new.
	self deny: instance isInDebugMode.
	
	instance debugOn. 
	self assert: instance isInDebugMode.
	
	instance debugOff.
	self deny: instance isInDebugMode.
	