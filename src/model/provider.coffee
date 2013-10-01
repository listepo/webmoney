# Авторские права - QuickSoft LLC

# Необходимые модули

Payment = require('./payment')
Invoice = require('./invoice')
Message = require('./message')

# Модель провайдера WebMoney

class Provider
	# Возвращает указанный WMID

	users: (wmid) -> new UserList(wmid)

	# Создает новый платеж

	createPayment: (data) -> new Payment(data)

	# Создает новый счет для оплаты

	createInvoice: (data) -> new Invoice(data)

	# Создает новое сообщение

	createMessage: (data) -> new Message(data)

# Объекты для экспорта

module.exports = Provider
