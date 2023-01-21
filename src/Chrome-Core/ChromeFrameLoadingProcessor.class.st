"
Process frame loading
"
Class {
	#name : #ChromeFrameLoadingProcessor,
	#superclass : #ChromeMessageProcessor,
	#instVars : [
		'frameId',
		'loading',
		'stoppedLoading',
		'loadedTimestamp',
		'idleProcess',
		'pageLoadDelay'
	],
	#category : #'Chrome-Core-Model'
}

{ #category : #'instance creation' }
ChromeFrameLoadingProcessor class >> frameId: frameId [

	^self new frameId: frameId
]

{ #category : #private }
ChromeFrameLoadingProcessor >> ensureIdleTimer [
	"Ensure that the idle timer is running.
	This method is called when frameId has completed loading and there are no other loading frames."

	idleProcess ifNotNil: [ ^self ].

	idleProcess := [ | done timeDiff frameLoaded |
		done := false.
		[ done ] whileFalse:
			[ (Delay forMilliseconds: 500) wait.
			frameLoaded := stoppedLoading includes: frameId.

			(loadedTimestamp isNotNil and: [ frameLoaded ]) ifTrue: [
				timeDiff := (DateAndTime now - loadedTimestamp) asMilliSeconds.

		 		timeDiff >= pageLoadDelay ifTrue:
					[ done := true.
					 semaphore signal. ]
				]
			].
		] forkNamed: 'Chrome Idle Timer'
]

{ #category : #accessing }
ChromeFrameLoadingProcessor >> frameId [
	^ frameId
]

{ #category : #accessing }
ChromeFrameLoadingProcessor >> frameId: aFrameId [
	"Set the frame ID
	Once the Id is set, the process loop will no longer access the queue, so we can process it now"

	frameId := aFrameId
]

{ #category : #initialize }
ChromeFrameLoadingProcessor >> initialize [

	super initialize.
	loading := Bag new.
	stoppedLoading := Bag new.
	pageLoadDelay := 2000
]

{ #category : #accessing }
ChromeFrameLoadingProcessor >> pageLoadDelay [
	^ pageLoadDelay
]

{ #category : #accessing }
ChromeFrameLoadingProcessor >> pageLoadDelay: anObject [
	pageLoadDelay := anObject
]

{ #category : #messages }
ChromeFrameLoadingProcessor >> processMessage: aMessageDictionary [

	| params messageFrameId |

	aMessageDictionary at: 'method' ifPresent:
		[ :method |
			params := aMessageDictionary at: 'params'.
			method = 'Page.frameStartedLoading' ifTrue:
				[
				messageFrameId := params at: 'frameId'.
				loading add: messageFrameId.
				].
			method = 'Page.frameStoppedLoading' ifTrue:
				[
				messageFrameId := params at: 'frameId'.
				loading remove: messageFrameId
					ifAbsent: [ StringSignal log: 'unable to remove ', messageFrameId printString ].
				stoppedLoading add: messageFrameId.
				].
			loading isEmpty ifTrue:
				[
				loadedTimestamp := DateAndTime now.
				self ensureIdleTimer ]
			ifFalse:
				[ loadedTimestamp := nil ].
		]
]
