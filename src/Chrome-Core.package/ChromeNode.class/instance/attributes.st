accessing
attributes
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	| attributeArray attributes |
	attributes := Dictionary new.
	attributeArray := dictionary at: 'attributes' ifAbsent: [^attributes].
	1 to: attributeArray size by: 2 do: [ :i |
		attributes at: (attributeArray at: i) put: (attributeArray at: i+1) ].
	^attributes