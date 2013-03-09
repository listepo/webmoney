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
	# Hide service properties

	Object.defineProperty(@, '__super__', enumerable: false)

	# Fetches selected items from the server

	fetch: (callback) ->
		# Сделать запрос на получение номеров кошельков
		# Отфильтровать полученные данные (filter)
		# Ограничить количество пунктов (skip, limit)

		# Сделать для каждого номера кошелька запрос на получение операций
		# Отфильтровать полученные данные (filter)
		# Объединить все полученные данные и отсортировать их
		# Ограничить количество пунктов (skip, limit)

		@

	# Refunds money to sender

	refund: (callback) -> @

# Exported objects

module.exports = OperationList
