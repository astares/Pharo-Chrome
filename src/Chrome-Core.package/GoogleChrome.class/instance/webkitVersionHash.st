private - accessing
webkitVersionHash
	"Return the protocol.json description"

	| matcher webkitVersion |
	webkitVersion := self version at: 'WebKit-Version'.
	matcher := '[1-9.]*\s\(@([0-9a-z]*)\)' asRegex.
	(matcher matches: webkitVersion)
		ifFalse: [ self error: 'Does not match' ].
	^ (matcher subexpression: 2) first: 6