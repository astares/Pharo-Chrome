tests
testHasPlatform

	self 
		shouldnt: [ ChromePlatform current ]  
		raise: Error