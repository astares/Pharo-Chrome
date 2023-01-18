operations - page
get: anURL
	"Navigate to the supplied URL, retrieve the DOM and answer the root node"

	self
		enableDOM;
		enablePage;
		navigateTo: anURL;
		getDocument;
		getMissingChildren.
	^self rootNode