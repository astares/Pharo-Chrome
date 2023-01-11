inspecting
gtInspectorNodeIn: composite
	<gtInspectorPresentationOrder: 1>

	^ (composite fastTable)
		title: 'Node';
		display: [ self dictionary associations ];
		column: 'Key'
			evaluated: [:each | GTObjectPrinter asTruncatedTextFrom: each key ];
		column: 'Value'
			evaluated: [:each | GTObjectPrinter asTruncatedTextFrom: each value ];
		send: [ :selection | selection ]