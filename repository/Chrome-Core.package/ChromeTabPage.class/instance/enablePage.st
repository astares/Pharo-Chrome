operations - page
enablePage

	^self sendMessageDictionary: {
        'method' -> 'Page.enable'
      } asDictionary