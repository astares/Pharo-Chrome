defaults
defaultExecutableLocation

	^#('/opt/google/chrome/chrome' '/usr/bin/chromium-browser') detect: [ :each | each asFileReference exists ].