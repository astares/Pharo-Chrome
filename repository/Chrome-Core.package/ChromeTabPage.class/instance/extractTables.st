accessing
extractTables
	"Answer a Dictionary of the tables in the receiver"

	| tableNodes tables tableId |

	tables := Dictionary new.
	tableNodes := self rootNode findAllTags: 'table'.
	tableNodes withIndexDo: [ :node :index |
		tableId := node attributeAt: 'id' ifAbsent: 'table', index asString.
		tables at: tableId put: (node tableData) ].
	^tables