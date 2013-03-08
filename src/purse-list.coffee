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
	# Return information about purses

	info: (callback) -> @

	# Return operation axis

	operations: () -> new OperationList(@service)

	# Return invoice axis

	invoices: () -> new InvoiceList(@service)

# Exported objects

module.exports = PurseList
