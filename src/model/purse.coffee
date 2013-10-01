# Авторские права - QuickSoft LLC

# Необходимые модули

List = require('./list')

# Модель кошелька в WebMoney

class Purse
	# Возвращает операции, совершенные с использованием кошелька

	operations: (selector) -> new OperationList(purse: @_id).filter(selector)

	# Возвращает выписанные счета для оплаты на кошелек

	outInvoices: (selector) -> new InvoiceList(purse: @_id).filter(selector)

	# Возвращает WMID, которому принадлежит кошелек

	owner: () -> new UserList(_id: @wmid)

# Список кошельков

class PurseList extends List
	#

	toArray: (callback) ->
		@_service.purses(wmid: @wmid, (error, list) ->
			callback?(null)

			undefined
		)

		@

# Объекты для экспорта

module.exports = Purse
