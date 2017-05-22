operating
enablePage

	^self sendMessageDictionary: {
        'method' -> 'Page.enable'
      } asDictionary