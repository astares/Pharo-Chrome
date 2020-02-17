inspecting
gtInspectorChildrenHierarchyIn: composite
	<gtInspectorPresentationOrder: 2>

	^ composite tree 
		title: 'Chidren Hierarchy';
		display: [ :root | self ];
		children: [ :each | each children ];
		format: [:each | each nodeName ]