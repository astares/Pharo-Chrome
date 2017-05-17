accessing
executableLocation

	^ExecutableLocation ifNil: [ ExecutableLocation := ChromePlatform current defaultExecutableLocation ]