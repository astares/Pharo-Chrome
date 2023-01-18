instance creation
fromDictionary: aJsonDictionary parent: parentNode

	^(self new)
		initialize: aJsonDictionary parent: parentNode;
		yourself