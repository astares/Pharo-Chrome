inspecting
gtInspectorChildrenIn: composite
	<gtInspectorPresentationOrder: 2>

	^ (composite fastTable)
		title: 'Children';
		display: [ self children ];
		column: 'Name' 
			evaluated: [:each | GTObjectPrinter asTruncatedTextFrom: each nodeName ];
		column: 'Value' 
			evaluated: [:each | GTObjectPrinter asTruncatedTextFrom: each dictionary ];
		send: [ :selection | selection ]
