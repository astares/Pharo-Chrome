private
checkMessages: aMessageDictionary
	"Process any queued messages, followed by the supplied message"

	messageQueue do: [ :messageDictionary |
		self checkMessage: messageDictionary ].
	messageQueue := OrderedCollection new.
	self checkMessage: aMessageDictionary.
