operating
get: anURL
	"Answer the ChromeNode of the requested page"
	| page rootNode |

	self open.
	page := self firstTab.
	rootNode := page get: anURL.
	self closeAndExit.
	^rootNode