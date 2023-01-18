private
checkResponse: responseDictionary

	(responseDictionary includesKey: 'error') ifTrue:
		[ self halt: 'looks like bad response' ].
	^true