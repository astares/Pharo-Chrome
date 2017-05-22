operating
getDOM

	^self sendMessageDictionary: ({
        'method' -> 'DOM.getDocument'
      } asDictionary)