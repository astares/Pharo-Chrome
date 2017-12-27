operations - dom
enableDOM

	^self sendMessage: ({
        'method' -> 'DOM.enable'
      } asDictionary)