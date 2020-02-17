baseline
baseline: spec
	<baseline>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		
		spec baseline: 'ZincHTTPComponents' with: [
				spec
					loads: 'WebSocket';
					repository: 'github://svenvc/zinc' ].
				 
		spec 
			package: #'Chrome-Core' with: [
				spec requires: #('ZincHTTPComponents'). ];
			package: #'Chrome-Tests-Core' with: [
				spec requires: #(#'Chrome-Core' ). ].
		spec 
			group: 'Core' with: #(#'Chrome-Core' );
			group: 'Tests' with: #(#'Chrome-Tests-Core' );
			group: 'all' with: #('Core' 'Tests' );
			group: 'default' with: #('all' ). ].
