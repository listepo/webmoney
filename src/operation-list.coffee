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
	# Return information about operations

	info: (callback) ->
		# Сделать запрос на получение номеров кошельков
		# Отфильтровать полученные данные (filter)
		# Ограничить количество пунктов (skip, limit)

		# Сделать для каждого номера кошелька запрос на получение операций
		# Отфильтровать полученные данные (filter)
		# Объединить все полученные данные и отсортировать их
		# Ограничить количество пунктов (skip, limit)

		@

	# Refund money to senders for selected operations

	refund: (callback) -> @

# Exported objects

module.exports = OperationList
