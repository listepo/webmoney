# WebMoney purse list
#
# March, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Required modules

LazyList = require('./lazy-list')
OperationList = require('./operation-list')
InvoiceList = require('./invoice-list')

# Purse list

class PurseList extends LazyList
	# Hide service properties

	Object.defineProperty(@, '__super__', enumerable: false)

	# Fetches selected items from the server

	fetch: (callback) -> @

	# Returns operation axis

	operations: () -> new OperationList(@service)

	# Returns invoice axis

	invoices: () -> new InvoiceList(@service)

# Exported objects

module.exports = PurseList
