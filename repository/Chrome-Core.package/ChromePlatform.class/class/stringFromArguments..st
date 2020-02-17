private - utilities
stringFromArguments: arguments
	"Answer a string representation of the supplied argument array"

	^String streamContents: [ :stream |
		arguments do: [ :argument |
			"Enclose arguments that aren't options in quotes"
			argument first = $- ifFalse:
				[
				stream
					<< ' "';
					<< argument;
					<< '"' 
				]
			ifTrue:
				[
				stream
					<< ' ';
					<< argument
				].
			].
		].