# WebMoney operation
#
# March, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Required modules

Model = require('./model')

# Operation

class Operation extends Model
	# Processes payment. CREATE & READ

	process: (callback) ->
		data = trans: @data

		@service.invoke(method: 'XMLTrans', data: data, callback: callback)	# X2 call

		@

	# Refunds money to the sender. CREATE & READ

	reverse: (callback) ->
		data = trans: @data

		@service.invoke(method: 'XMLTransMoneyback', data: data, callback: callback)	# X14 call

		@

	# Finishes protected operation. UPDATE & READ -> opertype, dateupd

	finish: (code, callback) ->
		data = finishprotect: wmtranid: @id, pcode: code

		@service.invoke(method: 'XMLFinishProtect', data: data, callback: callback)	# X5 call

		@

	# Rejects protected operations. UPDATE & READ -> opertype, dateupd

	reject: (callback) ->
		data = rejectprotect: wmtranid: @id

		@service.invoke(method: 'XMLRejectProtect', data: data, callback: callback)	# X13 call

		@

# Exported objects

module.exports = Operation
