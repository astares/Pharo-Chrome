settings
catalogSettingsOn: aBuilder
	<systemsettings>
	(aBuilder group: #chrome)
		label: 'Chrome';
		parent: #tools;
		description: 'All Google Chrome settings';
		with: [
			(aBuilder setting: #debugPort)
						target: self;
						label: 'Debug Port';
						default: ChromePlatform current defaultDebugPort;
						description: 'Port to use for (remote) Chrome debugging'.
			(aBuilder setting: #executableLocation)
				target: self;
				label: 'Executable';
				type: #FilePathEncoder;
				description: 'Location of the Google Chrome executable'
		]