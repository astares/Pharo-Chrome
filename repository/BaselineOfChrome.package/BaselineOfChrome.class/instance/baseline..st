baseline
baseline: spec
	<baseline>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec baseline: 'ZincHTTPComponents' with: [
				spec
					loads: 'WebSocket';
					repository: 'github://svenvc/ZincHTTPComponents' ].
		spec baseline: 'Beacon' with: [ 
			spec
				repository: 'github://pharo-project/pharo-beacon' ].
		spec baseline: 'AKGOSProcess' with: [ 
			spec
				repository: 'github://akgrant43/pharo-akgosprocess/mc' ].
		spec 
			package: #'Chrome-Core' with: [
				spec requires: #('ZincHTTPComponents' 'Beacon' 'AKGOSProcess'). ];
			package: #'Chrome-Tests-Core' with: [
				spec requires: #(#'Chrome-Core' ). ].
		spec 
			group: 'Core' with: #(#'Chrome-Core' );
			group: 'Tests' with: #(#'Chrome-Tests-Core' );
			group: 'all' with: #('Core' 'Tests' );
			group: 'default' with: #('all' ). ].
