accessing
tabPages

	| tabs |
	tabs := self class tabPages.
	tabs ifEmpty: [ self error: 'Unable to find a debug tab page.  Please close the browser and start again' ].
	^tabs