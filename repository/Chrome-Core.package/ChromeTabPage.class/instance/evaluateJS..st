operating
evaluateJS: javaScript

	^self sendMessage: ('\{
        "id": 1,
        "method": "Runtime.evaluate",
        "params": \{"expression": "{1}"}
      }' format: {javaScript})
