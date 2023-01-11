defaults
defaultExecutableLocation

	^ self defaultExecutableLocations detect: [ :arg1 |
		  arg1 asFileReference exists ]