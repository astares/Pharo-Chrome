operating
enableDebugger

	^self sendMessage: ('{
        "id": 1,
        "method": "Debugger.enable"
      }')