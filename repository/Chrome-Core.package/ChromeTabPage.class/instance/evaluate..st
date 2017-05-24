operations - runtime
evaluate: aString

	^self sendMessage: ('\{
        "id": 1,
        "method": "Runtime.evaluate",
        "params": \{"expression": "{1}"}
      }' format: {aString})