utilities
loadWebSocketSupport
	<script>
	
	Metacello new 
		repository: 'github://svnc/zinc/src';
		baseline: 'ZincHTTPComponents';
		load: 'WebSocket'