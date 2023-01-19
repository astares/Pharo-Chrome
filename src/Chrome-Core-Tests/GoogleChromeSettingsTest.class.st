"
Unit test for settings of google chrome
"
Class {
	#name : #GoogleChromeSettingsTest,
	#superclass : #TestCase,
	#category : 'Chrome-Core-Tests-Settings'
}

{ #category : #tests }
GoogleChromeSettingsTest >> testDebugPortIsInteger [

	self assert: GoogleChromeSettings debugPort isNumber
]
