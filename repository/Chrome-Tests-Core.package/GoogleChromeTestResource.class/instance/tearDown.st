running
tearDown

	| osProcess |

	page1html delete.
	osProcess := browser chromeProcess process.
	browser closeAndExit.
	[ osProcess isComplete ] whileFalse:
		[ (Delay forMilliseconds: 200) wait ].