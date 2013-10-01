# Авторские права - QuickSoft LLC

# Необходимые модули

List = require('./list')

# Счет на оплату

class Invoice extends Payable

#

class OutputInvoice extends Invoice
	#

	save: (callback) ->
		@

# Список счетов на оплату

class InvoiceList extends List
	#

	toArray: (callback) ->
		@

# Объекты для экспорта

module.exports = Invoice
