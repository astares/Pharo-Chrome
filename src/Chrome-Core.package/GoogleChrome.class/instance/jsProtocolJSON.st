utilities
jsProtocolJSON
	"Return the js_protocol.json"

	| base64 url |
	url := 'https://chromium.googlesource.com/chromium/src/+/' , self webkitVersionHash ,
			 '/third_party/WebKit/Source/platform/v8_inspector/js_protocol.json?format=TEXT'.
	base64 := (ZnEasy get: url) contents.
	(STON fromString: base64 base64Decoded) inspect