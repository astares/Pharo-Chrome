tests
testDebugOn
	|instance|
	instance := GoogleChrome new.
	self deny: instance isInDebugMode