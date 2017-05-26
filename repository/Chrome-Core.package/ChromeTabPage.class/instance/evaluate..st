operations - runtime
evaluate: aString

	^self sendMessageDictionary: {
        'method' -> 'Runtime.evaluate'.
        'params' -> {'expression' -> aString} asDictionary
      } asDictionary