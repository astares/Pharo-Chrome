A chrome tab page

Pharo communicates with a Chrome Tab using a web socket (webSocket) and asynchronous message sends.  A messageId is used to link requests and responses.

Since the browser can send event messages at any time, and also doesn't seem to like messages backing up, a separate message read process is forked.  Messages are read from the browser and passed on to all registered message processors (ChromeMessageProcessor subclasses).  Semaphores are used by ChromeMessageBrowser to signal the calling process when the requested state has been reached, e.g. a response to a request has been received, the page has "completed" loading, etc.

See GoogleChrome class>>exampleNavigation for an example of interacting with a ChromeTabPage.

Instance Variables:

	id:	<String> The page id assigned by the browser
	webSocketDebuggerUrl: <String> The URL assigned by the browser
	webSocket: <ZnWebSocket> the connection to the browser page
	messageId: <Integer> The last request message id used
	messageProcessors: <OrderedCollection> The currently registered ChromeMessageProcessors
	messageQueue: <OrderedCollection> All messages received from the browser.  For debugging only and should eventually be removed.
	rootNode: The root ChromeNode of the current page
	pageLoadDelay: The default number of milliseconds to wait for the page to become idle after nagivation.