# WebMoney operation list
#
# March, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Required modules

LazyList = require('./lazy-list')

# Operation list

class OperationList extends LazyList
	# Retrieve information about operations in the list

	info: (callback) -> @

	# Refund money to senders for selected operations

	refund: (callback) -> @

# Exported objects

module.exports = OperationList
