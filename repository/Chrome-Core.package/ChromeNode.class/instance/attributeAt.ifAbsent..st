accessing
attributeAt: attributeName ifAbsent: absentBlock

	^self attributes at: attributeName ifAbsent: [ absentBlock value ]