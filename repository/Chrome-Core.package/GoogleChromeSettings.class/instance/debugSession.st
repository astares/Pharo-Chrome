actions
debugSession
	"Set the Chrome user directory to our default to ensure that we are running our instance of Chrome.
	This is typically done if you are running chrome without the remote debugging port enabled, and don't want to close the browser"

	| debugDataDir |
	
	debugDataDir := FileLocator temp / 'pharo' / 'GoogleChrome' / 'debugSession'.
	debugDataDir ensureCreateDirectory.
	self userDataDir: debugDataDir.