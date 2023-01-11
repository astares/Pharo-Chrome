initialize
initialize

	super initialize.
	self
		debugOn;
		debugSession;
		debugPort: self class debugPort;
		disableGPU: false;
		headless: false