operating
enablePage

	^self sendMessage: ('{
        "id": 1,
        "method": "Page.enable"
      }')