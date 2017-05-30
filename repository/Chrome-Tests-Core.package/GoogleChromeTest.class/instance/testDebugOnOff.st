tests
testDebugOnOff
	|instance|
	
	instance := GoogleChrome new.
	self assert: instance isInDebugMode.
	
	instance debugOn. 
	self assert: instance isInDebugMode.
	
	instance debugOff.
	self deny: instance isInDebugMode.
	