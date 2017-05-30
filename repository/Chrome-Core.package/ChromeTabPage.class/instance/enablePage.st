operations - page
enablePage

	^self sendMessage: {
        'method' -> 'Page.enable'
      } asDictionary