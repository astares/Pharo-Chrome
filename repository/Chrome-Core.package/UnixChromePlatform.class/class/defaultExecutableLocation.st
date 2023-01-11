defaults
defaultExecutableLocation

	^self defaultExecutableLocations detect: [ :each | each asFileReference exists ]