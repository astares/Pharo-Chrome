operations - network
enableNetwork

	^self sendMessageDictionary: ({
        'method' -> 'Network.enable'
      } asDictionary)