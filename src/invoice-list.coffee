# WebMoney invoice list
#
# March, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Required modules

LazyList = require('./lazy-list')

# Invoice list

class InvoiceList extends LazyList
	# Hide service properties

	Object.defineProperty(@, '__super__', enumerable: false)

	# Fetches selected items from the server

	fetch: (callback) -> @

	# Pays selected invoices

	pay: () -> @

# Exported objects

module.exports = InvoiceList
