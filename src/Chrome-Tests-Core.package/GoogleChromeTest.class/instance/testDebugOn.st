tests
testDebugOn
	|instance|
	instance := GoogleChrome new.
	self assert: instance isInDebugMode