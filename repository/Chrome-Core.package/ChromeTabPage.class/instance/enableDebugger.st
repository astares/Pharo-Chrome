operations - debugger
enableDebugger

	^self sendMessage: {
        'method' -> 'Debugger.enable'
      } asDictionary.