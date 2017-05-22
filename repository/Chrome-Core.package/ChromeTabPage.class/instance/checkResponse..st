private
checkResponse: responseDictionary

	| ston |

	(responseDictionary at: 'result') isEmpty ifFalse:
		[ self halt: 'looks like bad response' ].
	^true