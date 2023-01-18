operating
updateTitle

	| result |

	result := self evaluate: 'document.title'.
	^self title: (((result at: 'result') at: 'result') at: 'value')