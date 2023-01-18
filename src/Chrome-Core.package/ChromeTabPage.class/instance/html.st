accessing
html

	| ston |

	ston := STON fromString: (self evaluate: 'document.documentElement.outerHTML').
	^((ston at: 'result') at: 'result') at: 'value'