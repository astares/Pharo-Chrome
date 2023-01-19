"
A test resource
"
Class {
	#name : #GoogleChromeTestResource,
	#superclass : #TestResource,
	#instVars : [
		'page1html',
		'browser',
		'page'
	],
	#category : 'Chrome-Core-Tests-Resources'
}

{ #category : #private }
GoogleChromeTestResource class >> page1source [

	^'<html>
<head>
<title>Pharo-Chrome Test Page</title>
</head>
<body>
<h1>Title One</h1>
<p>Paragraph One</p>
<ul>
<li><a href="http://pharo.org">Go to Pharo.Org</a> with some more text</li>
</ul>

<h2>Test Tables</h2>

<table id="First Table">
<tr><th>Col 1</th><th>Col 2</th></tr>
<tr><td>Cell 11</td><td>Cell 21</td></tr>
<tr><td>Cell 12</td><td>Cell 22</td></tr>
</table>

<table>
<tr><th>Col 1</th><th>Col 2</th><th>Col 3</th></tr>
<tr><td>Cell 11</td><td>Cell 21</td></tr>
<tr><td>Cell 12</td><td>Cell 22</td><td>Cell 23</td></tr>
</table>

</body>
</html>'
]

{ #category : #accessing }
GoogleChromeTestResource >> browser [
	^ browser
]

{ #category : #accessing }
GoogleChromeTestResource >> page [
	^ page
]

{ #category : #running }
GoogleChromeTestResource >> setUp [

	| settings |

	page1html := FileLocator temp / 'GoogleChromeTestResource-Page1.html'.
	page1html writeStreamDo:
		[ :stream | stream nextPutAll: self class page1source ]
	ifPresent:
		[ self error: page1html fullName, ' shouldn''t exist' ].
	browser := GoogleChrome new.
	settings := browser settings.
	settings
		debugOn;
		debugSession;
		headless: true.
	browser open.
	page := browser tabPages first.
	page
		enablePage;
		enableDOM;
		navigateTo: 'file://', page1html fullName;
		getDocument;
		getMissingChildren;
		updateTitle
]

{ #category : #running }
GoogleChromeTestResource >> tearDown [

	page1html delete
]
