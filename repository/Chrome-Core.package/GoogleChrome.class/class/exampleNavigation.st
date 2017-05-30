examples
exampleNavigation
	| chrome page logger |

	logger := InMemoryLogger new.
	logger start.
	chrome := GoogleChrome new
            debugOn;
				debugSession;
            open;
            yourself.
	page := chrome tabPages first.
	page enablePage.
	page enableDOM.
	page navigateTo: 'http://pharo.org'.
	page getDocument.
	page getMissingChildren.
	page updateTitle.
	logger stop.
	^{ chrome. page. logger. }