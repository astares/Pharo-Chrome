operations - network
enableNetwork

	^self sendMessage: ({
        'method' -> 'Network.enable'
      } asDictionary)