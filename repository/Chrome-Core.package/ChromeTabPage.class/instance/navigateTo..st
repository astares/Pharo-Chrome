operations - page
navigateTo: anURL

	| result processor |

	"Add the frame loading processor so it can collect messages until the frameId is known"
	processor := ChromeFrameLoadingProcessor frameId: nil.
	result := self sendMessageDictionary: {
        'method' -> 'Page.navigate'.
        'params' -> { 'url' -> anURL } asDictionary.
		} asDictionary.
	"Update the frame loading processor with the frame id.  This will trigger it to process all existing messages (not really)"
	processor frameId: ((result at: 'result') at: 'frameId').
	processor wait.
	^result.
