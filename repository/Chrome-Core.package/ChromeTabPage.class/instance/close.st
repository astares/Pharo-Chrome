initialize-release
close

	socketState := #closed.
	self webSocket close.
	webSocket := nil.