# Авторские права - QuickSoft LLC

# Необходимые модули

List = require('./list')

# Операция по переводу средств

class Operation

# Платеж

class Payment extends Operation
	# Проводит платеж

	process: (callback) ->
		@_service.createOperation(@data, () ->
			callback?(null)

			undefined
		)

		@

# Пополнение

class Deposition extends Operation
	# Завершает операцию с протекцией сделки

	finish: (code, callback) ->
		@_service.finishOperation(wmtranid: @_id, pcode: code, (error) ->
			callback?(null)

			undefined
		)

		@

	# Возвращает отправителю еще незавершенный платеж с протекцией

	reject: (callback) ->
		@_service.rejectOperation(wmtranid: @_id, (error) ->
			callback?(null)

			undefined
		)

		@

	# Производит бескомиссионный возврат средств отправителю

	reverse: (amount, callback) ->
		@_service.rejectOperation(inwmtranid: @_id, amount: amount, (error) ->
			callback?(null)

			undefined
		)

		@

# Список операций

class OperationList extends List
	#

	toArray: (callback) ->
		@_service.operations(purse: @purse, (error, list) ->
			callback?(null)

			undefined
		)

		@

# Объекты для экспорта

module.exports = Operation
