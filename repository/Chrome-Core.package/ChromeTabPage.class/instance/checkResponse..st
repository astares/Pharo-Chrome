private
checkResponse: responseDictionary

	| ston |

	(responseDictionary includesKey: 'error') ifTrue:
		[ self halt: 'looks like bad response' ].
	^true