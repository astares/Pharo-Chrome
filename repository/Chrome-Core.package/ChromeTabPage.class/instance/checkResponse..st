private
checkResponse: responseString

	| ston |

	ston := STON fromString: responseString.
	(ston at: 'result') isEmpty ifFalse:
		[ self halt: 'looks like bad response' ].
	^true