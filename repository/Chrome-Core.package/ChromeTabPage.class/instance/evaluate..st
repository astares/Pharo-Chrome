operations - runtime
evaluate: aString

	^self sendMessage: {
        'method' -> 'Runtime.evaluate'.
        'params' -> {'expression' -> aString} asDictionary
      } asDictionary