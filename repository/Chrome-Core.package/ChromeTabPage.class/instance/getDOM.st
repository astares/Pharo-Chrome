operating
getDOM

	^self sendMessage: ('{
        "id": 1,
        "method": "DOM.getDocument"
      }')