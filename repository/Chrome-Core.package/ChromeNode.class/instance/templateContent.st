accessing
templateContent
	"For a description of node attributes, please see https://chromedevtools.github.io/devtools-protocol/1-2/DOM/"

	^dictionary at: 'templateContent' ifAbsent: [nil]