operating
enableDOM

	^self sendMessage: ('{
        "id": 1,
        "method": "DOM.enable"
      }')