examples
exampleNavigation
	| chrome page |

	InMemoryLogger resetInstance.
	InMemoryLogger start.
	chrome := GoogleChrome new
            debugOn;
				debugSession;
            open;
            yourself.
	page := chrome tabPages first.
	page enablePage.
	page enableDOM.
	page navigateTo: 'http://www.asx.com.au/asx/markets/priceLookup.do?by=asxCodes&asxCodes=wbc%20nab%20cba'.
	"page navigateTo: 'http://pharo.org'."
	page getDocument.
	page getMissingChildren.
	page updateTitle.
	InMemoryLogger stopAll.
	^{ chrome. page. InMemoryLogger instance }