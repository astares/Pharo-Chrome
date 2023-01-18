utilities
browseProtocolJSON
	"Return the browser_protocol.json"

	| base64 url |
	url := 'https://chromium.googlesource.com/chromium/src/+/', self webkitVersionHash,
			 '/third_party/WebKit/Source/core/inspector/browser_protocol.json?format=TEXT'.
	base64 := (ZnEasy get: url) contents.
	(STON fromString: base64 base64Decoded) inspect