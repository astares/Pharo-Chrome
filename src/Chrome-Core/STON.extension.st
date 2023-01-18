Extension { #name : #STON }

{ #category : #'*Chrome-Core' }
STON class >> fromURL: aJSONURL [

	^self fromString: (ZnEasy get: aJSONURL) contents
]
