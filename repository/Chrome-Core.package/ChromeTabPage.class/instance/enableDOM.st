operating
enableDOM

	^self sendMessageDictionary: ({
        'method' -> 'DOM.enable'
      } asDictionary)