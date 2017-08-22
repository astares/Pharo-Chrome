instance creation
get: anURL
	"Answer the ChromeNode of the requested page"
	| chrome page |

	chrome := self new
            debugOn;
				debugSession;
            open;
            yourself.
	page := chrome tabPages first.
	page enablePage.
	page enableDOM.
	page navigateTo: anURL.
	page getDocument.
	page getMissingChildren.
	chrome closeAndExit.
	^page rootNode