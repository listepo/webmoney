# Авторские права - QuickSoft LLC

# Необходимые модули

extend = require('extend')
Document = require('./document')

# Список документов

class List
	# Конструктор объекта

	constructor: (selector) ->
		@_selector = selector

	# Возвращает новый спискок с пропуском указанного количества документов

	skip: (number) -> new List()

	# Возвращает новый список с числом документов не больше указанного

	limit: (count) -> new List()

	# Возвращает новый отфильтрованный список

	filter: (selector) -> new List()

	# Удаляет закешированные документы из списка

	invalidate: () -> @

# Объекты для экспорта

module.exports = List
