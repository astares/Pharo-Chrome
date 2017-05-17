accessing
debugPort
	"Return the debug port"
	
	^DebugPort ifNil: [ DebugPort := ChromePlatform current defaultDebugPort]