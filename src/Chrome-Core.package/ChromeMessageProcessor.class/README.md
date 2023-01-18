ChromeMessageProcessor is an abstract superclass.  Subclasses are created for each type of message, or group of messages that may  be received from the browser and require processing.

Documentation on the messages sent by the browser is available at: https://chromedevtools.github.io/devtools-protocol/tot/

The main responsibilities of message processors are:

- Process messages received from the browser and signal the semaphore when the original request has been satisfied.
- Ensure that processing times are kept small so that the message receiving loop is not blocked, causing the browser to stop sending messages.


Public API and Key Messages

- #processMessage: is sent by the message receive loop for each message received from the browser.

Internal Representation and Key Implementation Points.

    Instance Variables
	semaphore:		<Semaphore>


    Implementation Points