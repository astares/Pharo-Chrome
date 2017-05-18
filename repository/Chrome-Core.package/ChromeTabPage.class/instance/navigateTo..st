operating
navigateTo: anURL

	^self sendMessage: ('\{
        "id": 1,
        "method": "Page.navigate",
        "params": \{"url": "{1}"}
      }' format: {anURL})