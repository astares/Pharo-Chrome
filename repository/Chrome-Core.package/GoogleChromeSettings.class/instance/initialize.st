initialize
initialize

	super initialize.
	self
		debugPort: self class debugPort;
		disableGPU: false;
		headless: false.
