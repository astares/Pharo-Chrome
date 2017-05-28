running
setUp

	page1html := FileLocator temp / 'GoogleChromeTestResource-Page1.html'.
	page1html writeStreamDo: 
		[ :stream | stream nextPutAll: self class page1source ]
	ifPresent: 
		[ self error: page1html fullName, ' shouldn''t exist' ].
	browser := GoogleChrome new
		debugOn;
		debugSession;
		open;
		yourself.
	page := browser tabPages first.
	page 
		enablePage;
		enableDOM;
		navigateTo: 'file://', page1html fullName.