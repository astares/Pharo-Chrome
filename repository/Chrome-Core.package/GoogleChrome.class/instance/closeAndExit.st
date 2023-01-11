operating
closeAndExit
	"Ask the browser to exit"

	chromeProcess ifNotNil: [ chromeProcess sigterm ]