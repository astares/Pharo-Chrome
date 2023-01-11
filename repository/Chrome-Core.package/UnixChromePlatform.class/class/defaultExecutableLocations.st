defaults
defaultExecutableLocations
	"Returns the default executable locations where one can find chrome or chromium"

	^ #( '/opt/google/chrome/chrome'
		  '/usr/bin/chromium-browser'
	     '/usr/local/share/chromium/chrome'
	     '/usr/bin/chromium'
		  '/snap/bin/chromium'
	 )