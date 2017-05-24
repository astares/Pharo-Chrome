operations - dom
enableDOM

	^self sendMessageDictionary: ({
        'method' -> 'DOM.enable'
      } asDictionary)