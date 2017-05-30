enumerating
detect: aBlock ifNone: exceptionBlock
	"Evaluate aBlock with each of the receiver and child nodes as the argument.  
	Answer the first node for which aBlock evaluates to true. If none  
	evaluate to true, then evaluate the argument, exceptionBlock."

	^ self detect: aBlock ifFound: [ :element | element ] ifNone: exceptionBlock