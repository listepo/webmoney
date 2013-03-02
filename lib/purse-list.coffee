# WebMoney purse list
#
# March, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Required modules

LazyList = require('./lazy-list')

# Purse list

class PurseList extends LazyList
	# Retrieve information about purses in the list

	info: (callback) -> @

	# Retrieve list with owner of each purse in the list

	owner: () -> new LazyList(@service)

	# Retrieve list with operations relevant to purses in the list

	operations: () -> new LazyList(@service)

# Exported objects

module.exports = PurseList
