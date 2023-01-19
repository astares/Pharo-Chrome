"
Unit test for Chrome platform
"
Class {
	#name : #ChromePlatformTest,
	#superclass : #TestCase,
	#category : 'Chrome-Core-Tests-Utilities'
}

{ #category : #tests }
ChromePlatformTest >> testHasPlatform [

	self assert: ChromePlatform current notNil
]
