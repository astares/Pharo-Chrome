"
Baseline for Chrome project
"
Class {
	#name : #BaselineOfChrome,
	#superclass : #BaselineOf,
	#category : 'BaselineOfChrome'
}

{ #category : #utilities }
BaselineOfChrome class >> loadWebSocketSupport [
	<script>
	
	Metacello new 
		repository: 'github://svnc/zinc/src';
		baseline: 'ZincHTTPComponents';
		load: 'WebSocket'
]

{ #category : #baseline }
BaselineOfChrome >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		
		spec baseline: 'ZincHTTPComponents' with: [
				spec
					loads: 'Zinc-WebSocket-Core';
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

]
