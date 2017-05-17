accessing
debugPort
	"Return the debug port"
	
	^DebugPort ifNil: [ DebugPort := 9222 ]