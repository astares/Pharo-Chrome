operations - debugger
enableDebugger

	^self sendMessage: ('{
        "id": 1,
        "method": "Debugger.enable"
      }')