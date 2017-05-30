Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, "I represent a paragraph of text".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	frameId:		<Object>
	messageQueue:		<Object>


    Implementation Points

Try and signal when the page has 'loaded'.  Since Javascript can have timers and be updating at any time, there isn't a well defined definition of the page being completely loaded.

The current definition is:

- The specified frameId has been loaded.
- There are no outstanding frames being loaded
- The last frame completed loading at least timeout seconds ago (0.5s by default).