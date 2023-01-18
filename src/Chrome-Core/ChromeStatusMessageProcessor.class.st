"
Process status message from Chrome
"
Class {
	#name : #ChromeStatusMessageProcessor,
	#superclass : #ChromeMessageProcessor,
	#instVars : [
		'id',
		'result'
	],
	#category : 'Chrome-Core-Model'
}

{ #category : #'instance creation' }
ChromeStatusMessageProcessor class >> forMessageId: anInteger [

	^self new id: anInteger
]

{ #category : #accessing }
ChromeStatusMessageProcessor >> id [
	^ id
]

{ #category : #accessing }
ChromeStatusMessageProcessor >> id: anObject [
	id := anObject
]

{ #category : #messages }
ChromeStatusMessageProcessor >> processMessage: aMessageDictionary [

	(aMessageDictionary at: 'id' ifAbsent: [nil]) = id ifFalse: [ ^self ].
	result := aMessageDictionary.
	semaphore signal
]

{ #category : #accessing }
ChromeStatusMessageProcessor >> result [
	^ result
]
