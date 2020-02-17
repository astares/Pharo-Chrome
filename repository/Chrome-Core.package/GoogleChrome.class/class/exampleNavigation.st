examples
exampleNavigation
 
	<gtExample>
	| chrome page logger |

	logger := MemoryLogger new.
	logger start.
	chrome := self new
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
