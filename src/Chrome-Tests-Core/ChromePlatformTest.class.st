"
Unit test for Chrome platform
"
Class {
	#name : #ChromePlatformTest,
	#superclass : #TestCase,
	#category : 'Chrome-Tests-Core-Utilities'
}

{ #category : #tests }
ChromePlatformTest >> testHasPlatform [

	self assert: ChromePlatform current notNil
]
