accessing
children
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	^(dictionary at: 'children' ifAbsent: [#()]) collect: 
		[ :each | self class fromDictionary: each parent: self ].