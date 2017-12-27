operations - page
getLayoutMetrics

	| result |
	result := self sendMessage: {
        'method' -> 'Page.getLayoutMetrics'.
        'params' ->  { }
      } asDictionary.
	^result at: 'result'