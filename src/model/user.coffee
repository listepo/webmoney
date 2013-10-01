# Авторские права - QuickSoft LLC

# Необходимые модули

Purse = require('./purse')
List = require('./list')

#

class User
	# Создает новый кошелек

	createPurse: (data) -> new Purse(data)

	# Возвращает кошельки, принадлежащие пользователю

	purses: () -> new PurseList(wmid: @_id)

	# Возвращает счета, выписанные пользователю

	inInvoices: (selector) -> new InvoiceList(wmid: @_id).filter(selector)

# Объекты для экспорта

module.exports = WMID
