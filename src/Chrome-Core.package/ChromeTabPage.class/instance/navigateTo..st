operations - page
navigateTo: anURL

	| result processor |

	self assert: anURL isNotNil.
	"Add the frame loading processor so it can collect messages until the frameId is known"
	processor := ChromeFrameLoadingProcessor frameId: nil.
	processor pageLoadDelay: pageLoadDelay.
	self addMessageProcessor: processor.
	result := self sendMessage: {
        'method' -> 'Page.navigate'.
        'params' -> { 'url' -> anURL } asDictionary.
		} asDictionary.
	"Update the frame loading processor with the frame id.  This will also process any saved messages."
	processor frameId: ((result at: 'result') at: 'frameId').
	processor wait.
	"self removeMessageProcessor: processor."
	^result