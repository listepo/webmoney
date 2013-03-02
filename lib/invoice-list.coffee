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
	# Retrieve information about invoices in the list

	info: (callback) -> @

	# Pay selected invoices

	pay: () -> @

# Exported objects

module.exports = InvoiceList
