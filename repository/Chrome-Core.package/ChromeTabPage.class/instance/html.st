operating
html

	| ston |

	ston := STON fromString: (self evaluateJS: 'document.documentElement.outerHTML').
	^((ston at: 'result') at: 'result') at: 'value'