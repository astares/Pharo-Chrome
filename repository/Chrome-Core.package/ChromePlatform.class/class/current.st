accessing
current

	^self subclasses 
		detect: [:each | each isActive ] 
		ifNone: [ self error: 'No support for platform' ]