instance creation
log: aString category: aCategory
	^ self new 
		message: aString;
		category: aCategory;
		emit