running
tearDown

	| osProcess |

	page1html delete.
	(browser chromeProcess) ifNotNil: [ osProcess := browser chromeProcess process ].
	browser closeAndExit.
	osProcess ifNotNil: [
		[ osProcess isComplete ] whileFalse:
			[ (Delay forMilliseconds: 200) wait ]].