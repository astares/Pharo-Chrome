defaults
defaultExecutableLocation

	^ (((self class environment at: #WinRegistryKey)
			 localMachine
		    queryValue: 'Path'
		    fromSubkey:
		    'SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe')
		   allButLast: 1) , '\chrome.exe'